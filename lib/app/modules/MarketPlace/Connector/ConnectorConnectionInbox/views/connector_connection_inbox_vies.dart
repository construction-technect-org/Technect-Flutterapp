import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorConnectionInbox/controllers/connector_connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:gap/gap.dart';

class ConnectorConnectionInboxVies extends StatelessWidget {
  final controller = Get.put<ConnectorConnectionInboxController>(
    ConnectorConnectionInboxController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text("CONNECTION INBOX"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CommonTextField(
                onChange: (value) {
                  controller.searchConnections(value ?? "");
                },
                borderRadius: 22,
                hintText: 'Search',
                prefixIcon: SvgPicture.asset(
                  Asset.searchIcon,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    final colorMap = {
                      "pending": Colors.orange,
                      "accepted": Colors.green,
                      "rejected": Colors.red,
                      "cancelled": Colors.red,
                    };

                    final selectedColor =
                        colorMap[controller.selectedStatus.value]!;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedStatus.value,
                          dropdownColor: Colors.white,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22,
                            color: Colors.black,
                          ),
                          style: MyTexts.medium16.copyWith(
                            color: selectedColor,
                            fontFamily: MyTexts.Roboto,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "pending",
                              child: Text(
                                "Pending",
                                style: MyTexts.medium16.copyWith(
                                  color: Colors.orange,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "accepted",
                              child: Text(
                                "Accepted",
                                style: MyTexts.medium16.copyWith(
                                  color: Colors.green,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "rejected",
                              child: Text(
                                "Rejected",
                                style: MyTexts.medium16.copyWith(
                                  color: Colors.red,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "cancelled",
                              child: Text(
                                "Cancelled",
                                style: MyTexts.medium16.copyWith(
                                  color: Colors.red,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) async {
                            if (value != null) {
                              controller.selectedStatus.value = value;
                              await controller.fetchConnections();
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: MyColors.primary,
                color: Colors.white,
                onRefresh: () async {
                  controller.clearSearch();
                  await controller.fetchConnections();
                },
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: MyColors.primary),
                    );
                  } else if (controller.filteredConnections.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(20),
                            Icon(
                              controller.searchQuery.value.isNotEmpty
                                  ? Icons.search_off
                                  : Icons.people_outline,
                              size: 64,
                              color: MyColors.grey,
                            ),
                            // SizedBox(height: 1.h),
                            Text(
                              'No connections found',
                              style: MyTexts.medium18.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              controller.searchQuery.value.isNotEmpty
                                  ? 'Try searching with different keywords'
                                  : 'Connection requests will appear here',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.grey,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.filteredConnections.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final connection =
                            controller.filteredConnections[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CONNECTION_INBOX);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: MyColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              border: const Border(
                                left: BorderSide(
                                  color: MyColors.green,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: MyColors.grey,
                                        child:
                                            connection
                                                    .connectorProfileImageUrl !=
                                                null
                                            ? ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      APIConstants.bucketUrl +
                                                      connection
                                                          .connectorProfileImageUrl!,
                                                  width: 44,
                                                  height: 44,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const ColoredBox(
                                                        color:
                                                            MyColors.lightGray,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                            Icons.person,
                                                            color:
                                                                MyColors.white,
                                                          ),
                                                ),
                                              )
                                            : Icon(
                                                Icons.person,
                                                color: MyColors.white,
                                              ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${connection.connectorName ?? 'Unknown'} wants to connect with you",
                                              style: MyTexts.medium16.copyWith(
                                                color: MyColors.fontBlack,
                                                fontFamily: MyTexts.Roboto,
                                              ),
                                            ),
                                            const Gap(4),
                                            Text(
                                              "User   •   ${connection.createdAt?.toLocal().toString().split(' ')[0] ?? 'Unknown date'}",
                                              style: MyTexts.regular14.copyWith(
                                                color: MyColors.fontBlack,
                                                fontFamily: MyTexts.Roboto,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 1.h),

                                  // Product Name
                                  Text(
                                    "Product: ${connection.productName ?? 'Unknown Product'}",
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),

                                  SizedBox(height: 0.5.h),

                                  // Request Message
                                  Text(
                                    "Message: ${connection.requestMessage ?? 'No message'}",
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.darkGray,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                  if (connection.status == "pending")
                                    SizedBox(height: 2.h),
                                  if (connection.status == "pending")
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 2.w),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            ConnectionDialogs.showCancelConnectionDialog(
                                              context,
                                              connection,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                            color: MyColors.white,
                                          ),
                                          label: Text(
                                            "Cancel",
                                            style: MyTexts.medium14.copyWith(
                                              color: MyColors.white,
                                              fontFamily: MyTexts.Roboto,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
