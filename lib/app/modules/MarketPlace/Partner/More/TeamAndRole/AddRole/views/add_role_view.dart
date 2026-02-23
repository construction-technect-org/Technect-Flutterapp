import "dart:developer";


import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/controllers/add_role_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/permissions_model.dart';

class AddRoleView extends GetView<AddRoleController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.moreIBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      controller.isEdit.value ? "Edit Role" : "Add  Role",
                    ),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  CommonTextField(
                                    headerText: 'Role Title',
                                    hintText: "Enter the role",
                                    controller: controller.roleController,
                                    validator: (val) {
                                      if ((val ?? "").isEmpty) {
                                        return "Please enter the role";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 2.h),
                                  CommonTextField(
                                    headerText: 'Role Description',
                                    hintText: "Please add description",
                                    maxLine: 4,
                                    validator: (val) {
                                      if ((val ?? "").isEmpty) {
                                        return "Please enter the description";
                                      }
                                      return null;
                                    },
                                    controller: controller.roleDescription,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Functionalities',
                              style: MyTexts.medium15.copyWith(
                                color: MyColors.gray2E,
                              ),
                            ),
                            SizedBox(height: 1.2.h),
                            /*Obx(() {
                              return Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: controller.groupedPermissions.entries.map((
                                  item,
                                ) {
                                  return _buildFunctionalityChip(
                                    label: item!.value!.,
                                    keyValue: item!.key!,
                                    controller: controller,
                                  );
                                }).toList(),
                              );
                            }),*/
                            Obx(() {
                              if (controller.groupedPermissions.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(12),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: controller.groupedPermissions.entries.map((
                                    entry,
                                  ) {
                                    final String category = entry.key;
                                    final List<UserPermissions?> permissions =
                                        entry.value;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// 🔵 category header with select all
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              category.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                const Text("Select All"),
                                                Obx(() {
                                                  final bool allSelected = permissions
                                                      .every(
                                                        (p) =>
                                                            controller
                                                                .selected[p!
                                                                .id] ==
                                                            true,
                                                      );

                                                  return Checkbox(
                                                    value: allSelected,
                                                    onChanged: (val) {
                                                      controller
                                                          .selectAllCategory(
                                                            category,
                                                            val!,
                                                          );
                                                    },
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        /// 🔵 grid checkboxes 2 per row
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: permissions.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 4,
                                              ),
                                          itemBuilder: (context, index) {
                                            final perm = permissions[index];
                                            final String nm = perm!.code!;
                                            final parts = nm.split(".");
                                            final String finalName = parts.last
                                                .toUpperCase();

                                            return Obx(
                                              () => Row(
                                                children: [
                                                  Checkbox(
                                                    value:
                                                        controller
                                                            .selected[perm
                                                            .id] ??
                                                        false,
                                                    onChanged: (val) {
                                                      controller
                                                          .togglePermission(
                                                            perm.id ?? "",
                                                            val!,
                                                          );
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      finalName ?? "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),

                                        const Divider(height: 25),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() {
              return RoundedButton(
                buttonName: controller.isEdit.value ? 'Update' : 'Add',
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        if (controller.formKey.currentState!.validate()) {
                          log("roles saved ${controller.getSelectedIds()}");
                          log("Code saved ${controller.getCodeID()}");

                          //controller.saveRole();
                        }
                      },
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionalityChip({
    required String label,
    required String keyValue,
    required AddRoleController controller,
  }) {
    return Obx(() {
      final isSelected = controller.isFunctionalitySelected(keyValue);

      final backgroundColor = isSelected
          ? const Color(0xFFE1FFD4)
          : const Color(0xFFF7F7F7);
      final borderColor = isSelected
          ? const Color(0xFFC3E7C2)
          : const Color(0xFFEAEAEA);

      return GestureDetector(
        onTap: () => controller.toggleFunctionality(keyValue),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? Icons.check : Icons.circle_outlined,
                size: 12,
                color: Colors.black,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: MyTexts.medium15.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    });
  }
}
