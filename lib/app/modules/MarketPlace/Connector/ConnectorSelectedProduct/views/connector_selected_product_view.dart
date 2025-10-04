import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';

class ConnectorSelectedProductView extends StatelessWidget {
   ConnectorSelectedProductView({super.key});

  final controller = Get.put<ConnectorSelectedProductController>(ConnectorSelectedProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text("Select Category"),
        actions: [
          IconButton(
            icon: SvgPicture.asset(Asset.filterIcon, width: 20, height: 20),
            onPressed: () => _openFilterSheet(context),
          )
        ],
      ),
      body: Obx(() {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: controller.mainCategories.length,
          itemBuilder: (context, index) {
            final item = controller.mainCategories[index];
            return GestureDetector(
              onTap: () {
                controller.selectMainCategory(index);
                Get.to(() => ConnectorConfirmCategoryView(
                  selectedIndex: index,
                  categories: controller.mainCategories,
                ));
              },
              child: ConnectorCategoryCard(
                category: CategoryItem(item.name, Asset.Product),
              ),
            );
          },
        );
      }),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Delivery Radius", style: MyTexts.medium16),
                Slider(
                  min: 1,
                  max: 50,
                  divisions: 10,
                  value: controller.mapZoom.value,
                  label: "${controller.mapZoom.value.toInt()} KM",
                  onChanged: (val) => controller.mapZoom.value = val,
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Apply"),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}


class ConnectorConfirmCategoryView extends StatelessWidget {
  final int selectedIndex;
  final List<ConnectorCategory> categories;

  const ConnectorConfirmCategoryView({
    super.key,
    required this.selectedIndex,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Category"),
      ),
      body: Column(
        children: [
          // Selected category highlighted
          Padding(
            padding: const EdgeInsets.all(16),
            child: ConnectorCategoryCard(
              category: CategoryItem(selectedCategory.name, Asset.Product),
              isSelected: true,
            ),
          ),
          const Divider(),

          // Other categories
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                if (index == selectedIndex) return const SizedBox.shrink();
                final item = categories[index];
                return ConnectorCategoryCard(
                  category: CategoryItem(item.name, Asset.Product),
                );
              },
            ),
          ),

          // Select button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => ConnectorProductView(
                  category: selectedCategory,
                ));
              },
              child: const Text("Select"),
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectorProductView extends StatelessWidget {
  final ConnectorCategory category;

  const ConnectorProductView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Center(
        child: Text("Products of ${category.name} will be shown here"),
      ),
    );
  }
}
