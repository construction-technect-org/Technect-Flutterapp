import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/models/ConnectorServiceModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/services/ConstructionLineServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/views/delivery_location_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';

class ConstructionServiceController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  RxBool hasOpenedOnce = false.obs;

  RxInt navigationIndex = 0.obs;

  RxBool isLoadingServices = false.obs;
  RxBool isLoading = false.obs;
  RxBool moreThenHundred = false.obs;
  RxBool isGridView = true.obs;

  Rx<ServicesSubCategories> serviceCategories = ServicesSubCategories().obs;
  Rx<ConnectorServiceModel> serviceListModel = ConnectorServiceModel().obs;
  RxInt selectedServiceCategoryIndex = 0.obs;

  Rx<ServiceCategoryData?> mainCategory =
      ServiceCategoryData().obs; // Main Category
  RxList<ServicesSubCategories> subCategories =
      <ServicesSubCategories>[].obs; // Sub Category
  Rx<ServicesSubCategories?> selectedSubCategory = Rx<ServicesSubCategories?>(
    null,
  );
  RxList<ServiceCategories> serviceCategoryList = <ServiceCategories>[].obs;
  Rx<ServiceCategories?> selectedServiceCategory = Rx<ServiceCategories?>(null);

  // Arguments from navigation
  int? mainCategoryId;
  String? mainCategoryName;
  RxInt selectedSubCategoryId = 0.obs;
  double radiusKm = 50000000;

  final ConstructionLineServices constructionLineServices =
      ConstructionLineServices();

  @override
  void onInit() {
    super.onInit();
    if (myPref.role.val == "connector") {
      ever(hasOpenedOnce, (opened) {
        if (!opened) {
          Future.delayed(const Duration(milliseconds: 300), () {
            openAddressSelection();
          });
        }
      });
    }

    hasOpenedOnce.value = false;
    final arguments = Get.arguments as Map<String, dynamic>?;
    mainCategoryId = arguments?['mainCategoryId'] ?? 0;
    mainCategoryName = arguments?['mainCategoryName'] ?? 'Select Service';
    selectedSubCategoryId.value = arguments?['selectedSubCategoryId'] ?? 0;
    _initializeServiceCategories();
  }

  void openAddressSelection() {
    openSelectAddressBottomSheet(
      onAddressChanged: () async {
        hasOpenedOnce.value = true;
        await fetchServicesFromApi(isLoading: true);
      },
    );
  }

  void _initializeServiceCategories() {
    if (mainCategoryId != null) {
      final categoryHierarchy = myPref.getServiceCategoryHierarchyModel();

      mainCategory.value =
          categoryHierarchy?.data!.firstWhere(
            (category) => category.id == mainCategoryId,
          ) ??
          ServiceCategoryData();

      subCategories.value =
          mainCategory.value?.subCategories ?? <ServicesSubCategories>[];

      if (selectedSubCategoryId.value != 0) {
        selectedSubCategory.value = subCategories.firstWhere((element) {
          return selectedSubCategoryId.value == element.id;
        });
        serviceCategoryList.value =
            selectedSubCategory.value?.serviceCategories ??
            <ServiceCategories>[];
      }
    }
  }

  void selectMainCategory() {
    final categoryHierarchy = myPref.getServiceCategoryHierarchyModel();
    if (mainCategoryId != null && categoryHierarchy != null) {
      mainCategory.value =
          categoryHierarchy.data?.firstWhere((c) => c.id == mainCategoryId) ??
          ServiceCategoryData();
      subCategories.value =
          mainCategory.value?.subCategories ?? <ServicesSubCategories>[];
    }
  }

  void selectSubCategory(int index) {
    selectedSubCategoryId.value = subCategories[index].id ?? 0;
    selectedSubCategory.value = subCategories[index];
    serviceCategoryList.value =
        selectedSubCategory.value?.serviceCategories ?? <ServiceCategories>[];
  }

  void lestSide0LeftView(int index) {
    navigationIndex.value = 0;
    selectedSubCategoryId.value = subCategories[index].id ?? 0;
    selectedSubCategory.value = subCategories[index];
    serviceCategoryList.value =
        selectedSubCategory.value?.serviceCategories ?? [];
  }

  void rightSide0RightView(int index) {
    selectServiceCategory(index);
    serviceCategories.value =
        mainCategory.value?.subCategories?.firstWhere((element) {
          return element.id == serviceCategoryList[index].id;
        }) ??
        ServicesSubCategories();
    if (serviceCategories.value.serviceCategories?.isEmpty ?? true) {
      navigationIndex.value = 1;
    } else {
      selectedServiceCategoryIndex.value = index;
      navigationIndex.value = 1;
    }
    selectedServiceCategory.value = serviceCategoryList[index];
  }

  void leftSide1LeftView(int index) {
    navigationIndex.value = 1;
    selectedServiceCategoryIndex.value = index;
    selectedServiceCategory.value = serviceCategoryList[index];
    fetchServicesFromApi();
  }

  void leftSide2LeftView(int index) {
    selectedServiceCategoryIndex.value = index;
    selectedServiceCategory.value =
        serviceCategories.value.serviceCategories?[index] ??
        ServiceCategories();
  }

  void selectServiceCategory(int index) {
    selectedServiceCategory.value = serviceCategoryList[index];
    navigationIndex.value = 1;
    fetchServicesFromApi();
  }

  // Select service category
  void selectServiceCategoryFromGrid(int index) {
    selectedServiceCategoryIndex.value = index;
    selectedServiceCategory.value =
        serviceCategories.value.serviceCategories?[index] ??
        ServiceCategories();
    fetchServicesFromApi();
  }

  Future<void> fetchServicesFromApi({bool? isLoading}) async {
    if (selectedServiceCategory.value == null ||
        selectedSubCategory.value == null ||
        mainCategoryId == null) {
      return;
    }

    isLoadingServices.value = isLoading ?? true;

    try {
      serviceListModel.value = await constructionLineServices.connectorServices(
        mainCategoryId: mainCategoryId!,
        subCategoryId: selectedSubCategory.value!.id ?? 0,
        serviceCategoryId: selectedServiceCategory.value!.id ?? 0,
        page: 1,
        limit: 20,
        radiusKm: radiusKm,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch services: $e');
    } finally {
      isLoadingServices.value = false;
    }
  }

  void goBackToCategoryView() {
    if (navigationIndex.value == 0) {
      Get.back();
      return;
    }
    if (navigationIndex.value == 3) {
      navigationIndex.value = 2;
    } else if (navigationIndex.value == 2) {
      if (selectedSubCategory.value?.serviceCategories?.isEmpty ?? true) {
        navigationIndex.value = 1;
      } else {
        navigationIndex.value = 0;
      }
    } else {
      navigationIndex.value = 0;
    }
  }

  void selectProductSubCategory(int index) {
    selectedServiceCategoryIndex.value = index;
    selectedServiceCategory.value = serviceCategoryList[index];
    fetchServicesFromApi();
  }

  RxDouble selectedRadius = 50.0.obs;
  RxString selectedSort = 'Relevance'.obs;

  void updateRadius(double value) {
    selectedRadius.value = value;
  }

  Future<void> applyRadius() async {
    radiusKm = selectedRadius.value;
    await fetchServicesFromApi();
  }

  void applySorting(String sortType) {
    selectedSort.value = sortType;

    if (serviceListModel.value.data?.services != null) {
      final services = List<Service>.from(
        serviceListModel.value.data!.services ?? [],
      );
      switch (sortType) {
        case 'Price (Low to High)':
          services.sort(
            (a, b) => double.parse(
              a.price ?? '0',
            ).compareTo(double.parse(b.price ?? '0')),
          );
        case 'Price (High to Low)':
          services.sort(
            (a, b) => double.parse(
              b.price ?? '0',
            ).compareTo(double.parse(a.price ?? '0')),
          );
        case 'New Arrivals':
          services.sort(
            (a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''),
          );
        default:
          break;
      }
      serviceListModel.value = ConnectorServiceModel(
        success: serviceListModel.value.success,
        message: serviceListModel.value.message,
        data: ConnectorServiceData(
          services: services,
          pagination:
              serviceListModel.value.data?.pagination ?? ServicePagination(),
        ),
      );
      serviceListModel.refresh();
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
                      await fetchServicesFromApi();
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

  RxList<FilterData> allFilters = <FilterData>[].obs;

  Future<void> getFilter(String serviceCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().getFilter(
        int.parse(serviceCategoryId),
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
        return serviceCategoryList;
      default:
        return [];
    }
  }

  Future<void> addServiceToConnect({
    int? merchantProfileId,
    int? serviceId,
    String? message,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading(true);
      await constructionLineServices.addServiceToConnect(
        mID: merchantProfileId,
        sID: serviceId,
        message: message,
      );
      await fetchServicesFromApi(isLoading: false);
    } catch (e) {
    } finally {
      isLoading(false);
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
                  isBack: true,
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
