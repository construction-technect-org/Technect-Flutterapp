import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/views/delivery_location_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:gap/gap.dart';

class SelectedProductController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  RxBool hasOpenedOnce = false
      .obs;
  // Observable variables
  RxInt selectedProductIndex = (-1).obs;

  // Two-pane navigation index (0..4)
  RxInt navigationIndex = 0.obs;

  // View state handled via navigationIndex only (0..4)
  RxBool isLoadingProducts = false.obs;
  RxBool isLoading = false.obs;
  RxBool moreThenHundred = false.obs;
  RxBool showSubCategoryOptions = false.obs;

  // Product categories (from CategoryData model) and main products from API
  Rx<SubCategory> productCategories = SubCategory().obs;
  Rx<ConnectorSelectedProductModel?> productListModel =
      Rx<ConnectorSelectedProductModel?>(null);
  RxInt selectedProductCategoryIndex = 0.obs;
  RxInt selectedSubProductCategoryIndex = 0.obs;

  // Variables for categories and products
  Rx<CategoryData?> mainCategory = CategoryData().obs; // Main Category
  RxList<SubCategory> subCategories = <SubCategory>[].obs; // Sub Category
  Rx<SubCategory?> selectedSubCategory = Rx<SubCategory?>(null);
  RxList<ProductCategory> products = <ProductCategory>[].obs;
  Rx<ProductCategory?> selectedProduct = Rx<ProductCategory?>(null);
  RxList<ProductSubCategory> productSubCategories = <ProductSubCategory>[].obs;
  Rx<ProductSubCategory?> selectedProductSubCategory = Rx<ProductSubCategory?>(
    null,
  );

  // Arguments from navigation
  int? mainCategoryId;
  String? mainCategoryName;
  RxInt selectedSubCategoryId = 0.obs;
  double radiusKm = 50000000;

  // Service instance
  final ConnectorSelectedProductServices services =
      ConnectorSelectedProductServices();

  @override
  void onInit() {
    super.onInit();
    // Get arguments passed from home page
    ever(hasOpenedOnce, (opened) {
      if (!opened) {
        Future.delayed(const Duration(milliseconds: 300), () {
          openAddressSelection();
        });
      }
    });

    hasOpenedOnce.value = false; // Reset each time screen is created
    final arguments = Get.arguments as Map<String, dynamic>?;
    mainCategoryId = arguments?['mainCategoryId'] ?? 0;
    mainCategoryName = arguments?['mainCategoryName'] ?? 'Select Product';
    selectedSubCategoryId.value = arguments?['selectedSubCategoryId'] ?? 0;
    _initializeProductCategories();
  }
  void openAddressSelection() {
    openSelectAddressBottomSheet(
      onAddressChanged: () async {
        // When user selects an address
        // isAddressSelected.value = true;
        hasOpenedOnce.value = true;
        await fetchProductsFromApi(isLoading: true);
      },
    );
  }


  void _initializeProductCategories() {
    if (mainCategoryId != null) {
      final categoryHierarchy = myPref.getCategoryHierarchyModel();

      mainCategory.value =
          categoryHierarchy?.data!.firstWhere(
            (category) => category.id == mainCategoryId,
          ) ??
          CategoryData();

      subCategories.value =
          mainCategory.value?.subCategories ?? <SubCategory>[];

      if (selectedSubCategoryId.value != 0) {
        selectedSubCategory.value = subCategories.firstWhere((element) {
          return selectedSubCategoryId.value == element.id;
        });
        products.value =
            selectedSubCategory.value?.products ?? <ProductCategory>[];
      }
    }
  }

  // Explicitly (re)select the main category and refresh right-side subcategories
  void selectMainCategory() {
    final categoryHierarchy = myPref.getCategoryHierarchyModel();
    if (mainCategoryId != null && categoryHierarchy != null) {
      mainCategory.value =
          categoryHierarchy.data?.firstWhere((c) => c.id == mainCategoryId) ??
          CategoryData();
      subCategories.value =
          mainCategory.value?.subCategories ?? <SubCategory>[];
      // Stay on index 0: Left = main category, Right = subcategories
    }
  }

  // Methods
  void selectSubCategory(int index) {
    selectedSubCategoryId.value = subCategories[index].id ?? 0;
    selectedSubCategory.value = subCategories[index];
    products.value = selectedSubCategory.value?.products ?? [];
    productSubCategories.value =
        selectedSubCategory.value?.productSubCategories ??
        <ProductSubCategory>[];
    selectedProductIndex.value = -1; // Reset product selection
  }

  void lestSide0LeftView(int index) {
    navigationIndex.value = 0;
    selectedSubCategoryId.value = subCategories[index].id ?? 0;
    selectedSubCategory.value = subCategories[index];
    products.value = selectedSubCategory.value?.products ?? [];
    productSubCategories.value =
        selectedSubCategory.value?.productSubCategories ??
        <ProductSubCategory>[];
  }

  void rightSide0RightView(int index) {
    selectProduct(index);
    productCategories.value =
        mainCategory.value?.subCategories?.firstWhere((element) {
          return element.id == products[index].subCategoryId;
        }) ??
        SubCategory();
    if (productCategories.value.productSubCategories?.isEmpty ?? true) {
      navigationIndex.value = 1;
    } else {
      selectedProductCategoryIndex.value = index;
      navigationIndex.value = 2;
    }
    selectedProduct.value = products[index];
  }

  void leftSide1LeftView(int index) {
    navigationIndex.value = 1;
    selectedProductCategoryIndex.value = index;
    selectedProduct.value = products[index];
    if (productSubCategories.isNotEmpty) {
      return;
    }
    fetchProductsFromApi();
  }

  void leftSide2LeftView(int index) {
    selectedProductCategoryIndex.value = index;
    selectedProduct.value =
        productCategories.value.products?[index] ?? ProductCategory();
  }

  void rightSide2RightView(int index) {
    selectedSubProductCategoryIndex.value = index;
    selectedProductSubCategory.value = productSubCategories[index];
    fetchProductsFromApi();
  }

  void selectProduct(int index) {
    selectedProductIndex.value = index;
    selectedProduct.value = products[index];
    if (productSubCategories.isNotEmpty) {
      return;
    }
    fetchProductsFromApi();
  }

  // Call API when product is clicked
  Future<void> fetchProductsFromApi({
    bool? isLoading,
    Map<String, dynamic>? filtersData,
  }) async {
    if (selectedProduct.value == null || selectedSubCategory.value == null) {
      return;
    }

    isLoadingProducts.value = isLoading ?? true;

    final selectedAddress = homeController.profileData.value.data?.siteLocations
        ?.where((element) => element.isDefault == true)
        .first;

    String latitude = '';
    String longitude = '';

    if (selectedAddress != null) {
      final latitudeString = selectedAddress.latitude?.toString();
      final longitudeString = selectedAddress.longitude?.toString();
      if (latitudeString != null && longitudeString != null) {
        latitude = latitudeString;
        longitude = longitudeString;
      }
    }
    if (latitude.isEmpty || longitude.isEmpty) {
      SnackBars.errorSnackBar(
        content: 'No address found. Please add an address first.',
      );
      return;
    }
    try {
      // Call the service
      productListModel.value = await services.connectorProduct(
        mainCategoryId: mainCategoryId.toString(),
        subCategoryId: selectedSubCategory.value!.id.toString(),
        categoryProductId: selectedProduct.value!.id.toString(),
        productSubCategoryId: selectedProductSubCategory.value?.id?.toString(),
        radius: radiusKm.toInt(),
        latitude: latitude,
        longitude: longitude,
        filters: filtersData,
      );
      showSubCategoryOptions.value = false;

      if (allFilters.isEmpty) {
        getFilter(selectedProduct.value!.id.toString());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  // Select product category
  void selectProductCategory(int index) {
    selectedProductCategoryIndex.value = index;
    selectedProduct.value =
        productCategories.value.products?[index] ?? ProductCategory();
    if (productSubCategories.isNotEmpty) {
      return;
    }
    fetchProductsFromApi();
  }

  // Go back to category view
  void goBackToCategoryView() {
    if (navigationIndex.value == 0) {
      Get.back();
      return;
    }
    if (navigationIndex.value == 3) {
      navigationIndex.value = 2;
    } else if (navigationIndex.value == 2) {
      if (selectedSubCategory.value?.productSubCategories?.isEmpty ?? true) {
        navigationIndex.value = 1;
      } else {
        navigationIndex.value = 0;
      }
    } else {
      navigationIndex.value = 0;
    }
  }

  void selectProductSubCategory(int index) {
    selectedSubProductCategoryIndex.value = index;
    selectedProductSubCategory.value = productSubCategories[index];
    fetchProductsFromApi();
  }

  // Inside SelectedProductController
  RxDouble selectedRadius = 50.0.obs;
  RxString selectedSort = 'Relevance'.obs;

  void updateRadius(double value) {
    selectedRadius.value = value;
  }

  Future<void> applyRadius() async {
    radiusKm = selectedRadius.value;
    await fetchProductsFromApi();
  }

  void applySorting(String sortType) {
    selectedSort.value = sortType;

    if (productListModel.value?.data?.products != null) {
      final products = productListModel.value!.data!.products;
      switch (sortType) {
        case 'Price (Low to High)':
          products.sort(
            (a, b) => double.parse(
              a.price ?? '0',
            ).compareTo(double.parse(b.price ?? '0')),
          );
        case 'Price (High to Low)':
          products.sort(
            (a, b) => double.parse(
              b.price ?? '0',
            ).compareTo(double.parse(a.price ?? '0')),
          );
        case 'Ratings':
          products.sort(
            (a, b) => double.parse(
              b.ratingCount.toString(),
            ).compareTo(double.parse(a.ratingCount.toString())),
          );
        case 'New Arrivals':
          products.sort(
            (a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''),
          );
        default:
          break;
      }
      productListModel.refresh();
    }
  }

  void showSortBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(height: 4, width: 40, color: Colors.grey[400]),
              ),
              const SizedBox(height: 16),
              Text(
                'Sort by',
                style: MyTexts.medium16.copyWith(color: MyColors.black),
              ),
              const SizedBox(height: 12),
              ...[
                'Relevance',
                'New Arrivals',
                'Price (High to Low)',
                'Price (Low to High)',
                'Ratings',
              ].map((sortType) {
                return RadioListTile<String>(
                  dense: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                  selectedTileColor: MyColors.primary,

                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return MyColors.primary;
                    }
                    return Colors.grey;
                  }),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  title: Text(
                    sortType,
                    style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                  ),
                  value: sortType,
                  groupValue: selectedSort.value,
                  onChanged: (value) {
                    applySorting(value!);
                    Get.back();
                  },
                );
              }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showLocationBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select the radius',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.veryDarkGray,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                return GestureDetector(
                  onTap: () async {
                    moreThenHundred.value = !moreThenHundred.value;
                    Get.back();

                    if (moreThenHundred.value == true) {
                      radiusKm = 10000000000;
                      await fetchProductsFromApi();
                    } else {
                      await applyRadius();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: moreThenHundred.value == true
                          ? MyColors.primary
                          : MyColors.white,
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(color: MyColors.grayEA),
                    ),
                    child: Text(
                      'More than 100 km',
                      style: MyTexts.medium14.copyWith(
                        color: moreThenHundred.value == true
                            ? MyColors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '0 km',
                    style: MyTexts.medium14.copyWith(color: Colors.black),
                  ),
                  Expanded(
                    child: Slider(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      max: 100,
                      divisions: 10,
                      value: selectedRadius.value,
                      label: '${selectedRadius.value.toStringAsFixed(0)} km',
                      onChanged: (value) => updateRadius(value),
                      activeColor: MyColors.primary,
                    ),
                  ),
                  Text(
                    '100 km',
                    style: MyTexts.medium14.copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    moreThenHundred.value = false;
                    await applyRadius();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    final otherFilters = allFilters;
    if (filters.isEmpty) {
      filters.assignAll(
        otherFilters.map(
          (f) => ConnectorFilterModel(
            filterName: f.filterName,
            filterType: f.filterType,
            min: double.tryParse(f.minValue ?? '0'),
            max: double.tryParse(f.maxValue ?? '100'),
            options: f.dropdownList,
            label: f.filterLabel,
          ),
        ),
      );
      initFilterControllers();
    }

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Filter',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.veryDarkGray,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),

                /// FILTER LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      final filter = filters[index];
                      final isExpanded = expandedSection.contains(
                        filter.filterName,
                      );
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        // margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: !isExpanded
                              ? null
                              : const Border(
                                  bottom: BorderSide(color: MyColors.grayEA),
                                ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                filter.label ?? '',
                                style: MyTexts.bold16.copyWith(
                                  color: MyColors.fontBlack,
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                              trailing: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: MyColors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  if (isExpanded) {
                                    expandedSection.remove(
                                      filter.filterName ?? '',
                                    );
                                  } else {
                                    expandedSection.add(
                                      filter.filterName ?? '',
                                    );
                                  }
                                });
                              },
                            ),

                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 250),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              firstChild: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    switch (filter.filterType) {
                                      case 'number':
                                        final range =
                                            rangeValues[filter.filterName]!;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RangeSlider(
                                              values: range.value,
                                              min: filter.min ?? 0,
                                              max: filter.max ?? 100,
                                              divisions: 10,
                                              activeColor: MyColors.primary,
                                              onChanged: (val) {
                                                setState(() {
                                                  range.value = val;
                                                });
                                              },
                                            ),
                                            Text(
                                              "From ${range.value.start.toStringAsFixed(1)} to ${range.value.end.toStringAsFixed(1)}",
                                              style: MyTexts.regular14.copyWith(
                                                color: MyColors.grey,
                                              ),
                                            ),
                                          ],
                                        );

                                      case 'dropdown':
                                        return Align(
                                          alignment: AlignmentGeometry.topLeft,
                                          child: Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children:
                                                filter.options?.map((opt) {
                                                  final selected =
                                                      selectedFilters[filter
                                                              .filterName]
                                                          ?.value ==
                                                      opt;
                                                  return FilterChip(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                    label: Text(
                                                      opt,
                                                      style: MyTexts.medium16
                                                          .copyWith(
                                                            color: selected
                                                                ? Colors.white
                                                                : MyColors
                                                                      .gra54,
                                                          ),
                                                    ),
                                                    selected: selected,
                                                    backgroundColor:
                                                        const Color(0xFFFAFBFF),
                                                    selectedColor:
                                                        MyColors.primary,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    checkmarkColor:
                                                        Colors.white,
                                                    onSelected: (val) {
                                                      setState(() {
                                                        if (val) {
                                                          selectedFilters[filter
                                                                      .filterName]
                                                                  ?.value =
                                                              opt;
                                                        } else {
                                                          selectedFilters[filter
                                                                      .filterName]
                                                                  ?.value =
                                                              '';
                                                        }
                                                      });
                                                    },
                                                  );
                                                }).toList() ??
                                                [],
                                          ),
                                        );

                                      case 'dropdown_multiple':
                                        return Align(
                                          alignment: AlignmentGeometry.topLeft,
                                          child: Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children:
                                                filter.options?.map((opt) {
                                                  final list =
                                                      multiSelectValues[filter
                                                          .filterName]!;
                                                  final selected = list
                                                      .contains(opt);
                                                  return FilterChip(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                    label: Text(
                                                      opt,
                                                      style: MyTexts.medium16
                                                          .copyWith(
                                                            color: selected
                                                                ? Colors.white
                                                                : MyColors
                                                                      .gra54,
                                                          ),
                                                    ),
                                                    selected: selected,
                                                    backgroundColor:
                                                        const Color(0xFFFAFBFF),
                                                    selectedColor:
                                                        MyColors.primary,
                                                    checkmarkColor:
                                                        Colors.white,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    onSelected: (val) {
                                                      setState(() {
                                                        if (val) {
                                                          list.add(opt);
                                                        } else {
                                                          list.remove(opt);
                                                        }
                                                      });
                                                    },
                                                  );
                                                }).toList() ??
                                                [],
                                          ),
                                        );

                                      default:
                                        return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                              secondChild: const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedButton(
                          color: Colors.white,
                          borderColor: MyColors.primary,
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.primary,
                          ),
                          buttonName: "Clear All",
                          onTap: () {
                            setState(() async {
                              selectedFilters.clear();
                              multiSelectValues.clear();
                              initFilterControllers();
                              expandedSection.clear();
                              await fetchProductsFromApi();
                              Get.back();
                            });
                          },
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: RoundedButton(
                          buttonName: "Apply",
                          onTap: () async {
                            final filtersData = getFinalFilterData();
                            await fetchProductsFromApi(
                              filtersData: filtersData,
                            );
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  RxList<FilterData> allFilters = <FilterData>[].obs;

  Future<void> getFilter(String subCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().getFilter(
        int.parse(subCategoryId),
      );

      if (result.success == true) {
        allFilters.value = (result.data as List<FilterData>)
            .map((e) => e)
            .toList();
      } else {
        allFilters.clear();
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      allFilters.clear();
    } finally {
      isLoading(false);
    }
  }

  RxList<ConnectorFilterModel> filters = <ConnectorFilterModel>[].obs;
  RxMap<String, dynamic> selectedFilters = <String, dynamic>{}.obs;
  Map<String, Rx<RangeValues>> rangeValues = {};
  Map<String, RxList<String>> multiSelectValues = {};
  RxBool isLoad = false.obs;

  void initFilterControllers() {
    for (final filter in allFilters) {
      if (filter.filterType == 'number') {
        rangeValues[filter.filterName ?? ''] = RangeValues(
          double.parse(filter.minValue ?? "0"),
          double.parse(filter.maxValue ?? "0"),
        ).obs;
      } else if (filter.filterType == 'dropdown_multiple') {
        multiSelectValues[filter.filterName ?? ''] = <String>[].obs;
      } else if (filter.filterType == 'dropdown') {
        selectedFilters[filter.filterName ?? ''] = ''.obs;
      } else {
        selectedFilters[filter.filterName ?? ''] = ''.obs;
      }
    }
  }

  RxList<String> expandedSection = <String>[].obs;

  Map<String, dynamic> getFinalFilterData() {
    final filtersMap = <String, dynamic>{};

    for (final filter in allFilters) {
      final name = filter.filterName ?? '';

      switch (filter.filterType) {
        case 'number':
          final range = rangeValues[name]?.value;
          if (range != null) {
            filtersMap[name] = {
              "type": "range",
              "filter_type": "number",
              "min": range.start,
              "max": range.end,
            };
          }

        case 'dropdown_multiple':
          final list = multiSelectValues[name]?.toList() ?? [];
          filtersMap[name] = {
            "type": "list",
            "filter_type": "dropdown_multiple",
            "list": list,
          };

        case 'dropdown':
          final selectedValue = selectedFilters[name]?.value;
          if (selectedValue != null && selectedValue.isNotEmpty == true) {
            filtersMap[name] = {
              "type": "list",
              "filter_type": "dropdown",
              "list": [selectedValue],
            };
          }

        default:
          final selected = selectedFilters[name]?.value ?? '';
          if (selected.isNotEmpty == true) {
            filtersMap[name] = {
              "type": "list",
              "filter_type": filter.filterType ?? 'dropdown',
              "list": [selected],
            };
          }
      }
    }
    return filtersMap;
  }

  List<dynamic> get rightPanelItems {
    switch (navigationIndex.value) {
      case 0:
        return subCategories;
      case 1:
        return products; // local categories (not API)
      case 2:
        return productSubCategories.isNotEmpty
            ? productSubCategories
            : (productListModel.value?.data?.products ?? []);
      case 3:
        return productListModel.value?.data?.products ?? [];
      case 4:
        return productListModel.value?.data?.products ?? [];
      default:
        return [];
    }
  }

  void openSelectAddressBottomSheet({
    required Future<void> Function() onAddressChanged,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Text(
                "Select Address",
                style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
              ),
              const SizedBox(height: 16),

              Obx(() {
                final addresses =
                    homeController.profileData.value.data?.siteLocations ?? [];

                if (addresses.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text("No saved addresses found."),
                    ),
                  );
                }

                return CommonAddressList(
                  addresses: addresses,
                  onEdit: homeController.editAddress,
                  onDelete: homeController.deleteAddress,
                  onSetDefault: (addressId) async {
                    await homeController.setDefaultAddress(
                      addressId,
                      onSuccess: () async {
                        Get.back();
                        await onAddressChanged();
                      },
                    );
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
