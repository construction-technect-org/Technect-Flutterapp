import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/controllers/connection_inbox_controller.dart';
import 'package:gap/gap.dart';

class ConnectionInboxView extends StatelessWidget {
  final ConnectionInboxController controller = Get.put(ConnectionInboxController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          isCenter: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text("CONNECTION INBOX"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CommonTextField(
                  onChange: (value) {},
                  borderRadius: 22,
                  hintText: 'Search',
                  suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                  prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: Obx(() {
                  if (controller.connections.isEmpty) {
                    return const Center(child: Text("No connection requests found"));
                  } else {
                    return ListView.builder(
                      itemCount: controller.connections.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final connection = controller.connections[index];
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
                                left: BorderSide(color: MyColors.green, width: 2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top Row: Avatar + Text
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        child: connection.connectorProfileImageUrl != null
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
                                                        color: MyColors.lightGray,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                  errorWidget: (context, url, error) =>
                                                      Icon(
                                                        Icons.person,
                                                        color: MyColors.white,
                                                      ),
                                                ),
                                              )
                                            : Icon(Icons.person, color: MyColors.white),
                                      ),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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

                                  SizedBox(height: 2.h),

                                  // Buttons Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Connect Button
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          ConnectionDialogs.showAcceptConnectionDialog(
                                            context,
                                            connection,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          color: MyColors.white,
                                        ),
                                        label: Text(
                                          "Connect",
                                          style: MyTexts.medium14.copyWith(
                                            color: MyColors.white,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColors.primary,
                                          // Navy Blue
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      // Disconnect Button
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          ConnectionDialogs.showRejectConnectionDialog(
                                            context,
                                            connection,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: MyColors.white,
                                        ),
                                        label: Text(
                                          "Disconnect",
                                          style: MyTexts.medium14.copyWith(
                                            color: MyColors.white,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
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
            ],
          ),
        ),
      ),
    );
  }
}
