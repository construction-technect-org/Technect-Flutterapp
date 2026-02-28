import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_permission_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/incoming_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/outgoing_model.dart';

class ConnectionInboxView extends StatelessWidget {
  final ConnectionInboxController controller = Get.put(ConnectionInboxController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoader,
      child: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            isCenter: false,
            leading: const SizedBox(),
            leadingWidth: 0,
            title: const Text("Connection Inbox"),

            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.blueAccent),
                onPressed: () {
                  controller.refreshData();
                },
              ),
            ],
          ),
          body: (PermissionLabelUtils.canShow(PermissionKeys.connectionManager))
              ? Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Asset.loginBg), fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      children: [
                        // SizedBox(height: 1.h),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        //   child: CommonTextField(
                        //     onChange: (value) {
                        //       controller.searchConnections(value ?? "");
                        //     },
                        //     borderRadius: 22,
                        //     hintText: 'Search',
                        //     prefixIcon: SvgPicture.asset(
                        //       Asset.searchIcon,
                        //       height: 16,
                        //       width: 16,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 1.5.h),
                        Obx(
                          () => Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: MyColors.grayEA,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.onTabChanged(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: controller.selectedTabIndex.value == 0
                                            ? MyColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Received",
                                          style: MyTexts.medium14.copyWith(
                                            color: controller.selectedTabIndex.value == 0
                                                ? Colors.white
                                                : MyColors.fontBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                /// SENT TAB
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.onTabChanged(1),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: controller.selectedTabIndex.value == 1
                                            ? MyColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Sent",
                                          style: MyTexts.medium14.copyWith(
                                            color: controller.selectedTabIndex.value == 1
                                                ? Colors.white
                                                : MyColors.fontBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Expanded(
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(color: MyColors.primary),
                              );
                            }

                            // ✅ TAB 0 → RECEIVED
                            if (controller.selectedTabIndex.value == 0) {
                              if (controller.incomingConnections.isEmpty) {
                                return _buildEmptyState("No connection requests");
                              }

                              return ListView.builder(
                                itemCount: controller.incomingConnections.length,
                                itemBuilder: (context, index) {
                                  final item = controller.incomingConnections[index];
                                  return ReceivedConnectionCard(
                                    item: item,
                                    onBlock: () => ConnectionDialogs.showBlockDialog(context, item),
                                    onReject: () =>
                                        ConnectionDialogs.showDeclineDialog(context, item),
                                    onAccept: () =>
                                        ConnectionDialogs.showAcceptDialog(context, item),
                                  );
                                },
                              );
                            }
                            // ✅ TAB 1 → SENT
                            else {
                              if (controller.outgoingConnections.isEmpty) {
                                return _buildEmptyState("No sent requests");
                              }

                              return ListView.builder(
                                itemCount: controller.outgoingConnections.length,
                                itemBuilder: (context, index) {
                                  final item = controller.outgoingConnections[index];
                                  return ConnectionCard(
                                    item: item,
                                    onBlock: () =>
                                        ConnectionDialogs.showBlockOutgoingDialog(context, item),
                                    onRemove: () {
                                      if (item.status == "pending") {
                                        ConnectionDialogs.showWithdrawDialog(context, item);
                                      } else {
                                        ConnectionDialogs.showRemoveDialog(context, item);
                                      }
                                    },
                                    onMessage: () {},
                                  );
                                },
                              );
                            }
                          }),
                        ),
                        // Expanded(
                        //   child: Obx(() {
                        //     if (controller.isLoading.value) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(color: MyColors.primary),
                        //       );
                        //     }
                        //     else if (controller.filteredConnections.isNotEmpty) {
                        //       return SingleChildScrollView(
                        //         physics: const AlwaysScrollableScrollPhysics(),
                        //         child: SizedBox(
                        //           height: MediaQuery.of(context).size.height * 0.7,
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text(
                        //                 controller.searchQuery.value.isNotEmpty
                        //                     ? 'No connections found'
                        //                     : 'No connection requests',
                        //                 style: MyTexts.medium16.copyWith(
                        //                   color: MyColors.fontBlack,
                        //                   fontFamily: MyTexts.SpaceGrotesk,
                        //                 ),
                        //               ),
                        //               SizedBox(height: 0.5.h),
                        //               Text(
                        //                 controller.searchQuery.value.isNotEmpty
                        //                     ? 'Try searching with different keywords'
                        //                     : 'Connection requests will appear here',
                        //                 style: MyTexts.regular14.copyWith(
                        //                   color: MyColors.grey,
                        //                   fontFamily: MyTexts.SpaceGrotesk,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //     else {
                        //       if (controller.selectedTabIndex.value == 0) {
                        //         return ListView.builder(
                        //           itemCount: receivedList.length,
                        //           itemBuilder: (context, index) {
                        //             final item = receivedList[index];
                        //             return ReceivedConnectionCard(
                        //               name: item["name"],
                        //               designation: item["designation"],
                        //               imageUrl: item["imageUrl"],
                        //               timeAgo: item["timeAgo"],
                        //               status: item["status"],
                        //               onBlock: () {
                        //                 // ConnectionDialogs.showBlockDialog(context, item, "Block");
                        //               },
                        //               onReject: () {
                        //                 // ConnectionDialogs.showBlockDialog(context, item, "Decline");
                        //               },
                        //               onAccept: () {
                        //                 // ConnectionDialogs.showRemoveConnectionDialog(context, item);
                        //               },
                        //             );
                        //           },
                        //         );
                        //         // return ListView.builder(
                        //         //   itemCount: controller.incomingConnections.length,
                        //         //   itemBuilder: (context, index) {
                        //         //     final item = controller.incomingConnections[index];
                        //         //     return ReceivedCard(item: item);
                        //         //   },
                        //         // );
                        //       } else {
                        //        return ListView.builder(
                        //           itemCount: controller.outgoingConnections.length,
                        //           itemBuilder: (context, index) {
                        //             final item = connectionList[index];
                        //             return ConnectionCard(
                        //              item: item,
                        //               onBlock: () {},
                        //               onRemove: () {},
                        //               onMessage: () {},
                        //             );
                        //           },
                        //         );
                        //         // return ListView.builder(
                        //         //   itemCount: controller.outgoingConnections.length,
                        //         //   itemBuilder: (context, index) {
                        //         //     final item = controller.outgoingConnections[index];
                        //         //     return SentCard(item: item);
                        //         //   },
                        //         // );
                        //       }
                        //     }
                        //   }),
                        // ),
                        // Expanded(
                        //   child: RefreshIndicator(
                        //     backgroundColor: MyColors.primary,
                        //     color: Colors.white,
                        //     onRefresh: () async {
                        //       controller.clearSearch();
                        //       await controller.fetchIncomingConnections();
                        //     },
                        //     child: Obx(() {
                        //       if (controller.isLoading.value) {
                        //         return const Center(
                        //           child: CircularProgressIndicator(
                        //             color: MyColors.primary,
                        //           ),
                        //         );
                        //       } else if (controller
                        //           .filteredConnections
                        //           .isEmpty) {
                        //         return SingleChildScrollView(
                        //           physics:
                        //               const AlwaysScrollableScrollPhysics(),
                        //           child: SizedBox(
                        //             height:
                        //                 MediaQuery.of(context).size.height *
                        //                 0.7,
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   controller
                        //                           .searchQuery
                        //                           .value
                        //                           .isNotEmpty
                        //                       ? 'No connections found'
                        //                       : 'No connection requests',
                        //                   style: MyTexts.medium16.copyWith(
                        //                     color: MyColors.fontBlack,
                        //                     fontFamily: MyTexts.SpaceGrotesk,
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 0.5.h),
                        //                 Text(
                        //                   controller
                        //                           .searchQuery
                        //                           .value
                        //                           .isNotEmpty
                        //                       ? 'Try searching with different keywords'
                        //                       : 'Connection requests will appear here',
                        //                   style: MyTexts.regular14.copyWith(
                        //                     color: MyColors.grey,
                        //                     fontFamily: MyTexts.SpaceGrotesk,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       } else {
                        //         return ListView.builder(
                        //           physics:
                        //               const AlwaysScrollableScrollPhysics(),
                        //           itemCount:
                        //               controller.filteredConnections.length,
                        //           padding: const EdgeInsets.symmetric(
                        //             horizontal: 16,
                        //           ),
                        //           itemBuilder: (context, index) {
                        //             final connection =
                        //                 controller.filteredConnections[index];
                        //             return InkWell(
                        //               onTap: () {},
                        //               child: Container(
                        //                 margin: const EdgeInsets.only(
                        //                   bottom: 12,
                        //                 ),
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(
                        //                     16,
                        //                   ),
                        //                   color: MyColors.white,
                        //                   boxShadow: const [
                        //                     BoxShadow(
                        //                       color: MyColors.grayEA,
                        //                       blurRadius: 4,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 child: myPref.role.val == "connector"
                        //                     ? buildConnector(
                        //                         connection,
                        //                         context,
                        //                       )
                        //                     : buildPartner(connection, context),
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       }
                        //     }),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                )
              : const Center(child: NoPermissionWidget(message: 'No permission for this section')),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String text) {
    return Center(
      child: Text(text, style: MyTexts.medium16.copyWith(color: MyColors.fontBlack)),
    );
  }
}

class ReceivedConnectionCard extends StatelessWidget {
  final IncomingConnection item;
  final VoidCallback onBlock;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const ReceivedConnectionCard({
    super.key,
    required this.item,
    required this.onBlock,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          /// ✅ Avatar
          // Container(
          //   height: 55,
          //   width: 55,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //   ),
          //   child: ClipOval(
          //     child: CachedNetworkImage(
          //       imageUrl:
          //       item.connectorProfile.?.logo?.url ??
          //           "https://via.placeholder.com/150",
          //       fit: BoxFit.cover,
          //       placeholder: (context, url) => const Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //       errorWidget: (context, url, error) =>
          //       const Icon(Icons.category, size: 40),
          //     ),
          //   ),
          // ),
          SizedBox(width: 2.w),

          /// ✅ Name + Designation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.connectorProfile?.verificationDetails?.name ?? "NA",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified_outlined, size: 14, color: MyColors.primary),
                  ],
                ),
                Text(
                  item.requestedByProfileType,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          /// ✅ Actions + Time
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// Block + Reject + Accept
                if (item.status == "pending") ...[
                  Row(
                    children: [
                      /// Block
                      GestureDetector(
                        onTap: onBlock,
                        child: Icon(Icons.block_outlined, size: 20, color: Colors.grey.shade400),
                      ),

                      SizedBox(width: 2.w),

                      /// ✅ Reject — X
                      GestureDetector(
                        onTap: onReject,
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Color(0xFFC82222), // ✅ red
                        ),
                      ),

                      SizedBox(width: 2.w),

                      /// ✅ Accept — ✓
                      GestureDetector(
                        onTap: onAccept,
                        child: const Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: Colors.green, // ✅ green
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          item.status,
                          style: TextStyle(fontSize: 11, color: MyColors.white),
                        ),
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 0.5.h),

                /// ✅ Time
                Text(
                  timeAgo(item.requestedAt),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '${months}m ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return '${years}y ago';
    }
  }
}

class ConnectionCard extends StatelessWidget {
  final OutgoingConnection item;
  final VoidCallback onBlock;
  final VoidCallback onRemove;
  final VoidCallback onMessage;

  const ConnectionCard({
    super.key,
    required this.item,
    required this.onBlock,
    required this.onRemove,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          /// ✅ Avatar
          Stack(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: item.merchantProfile?.logo?.url ?? "https://via.placeholder.com/150",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.category, size: 40),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 2.w),

          /// ✅ Name + Designation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.merchantProfile?.businessName ?? "N/A",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified_outlined, size: 14, color: MyColors.primary),
                  ],
                ),
                Text(
                  item.requestedByProfileType ?? "NA",
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          /// ✅ Status Badge
          if (_buildStatusBadge() != null) _buildStatusBadge()!,

          SizedBox(width: 2.w),

          /// ✅ Block Icon
          GestureDetector(
            onTap: onBlock,
            child: Icon(Icons.block_outlined, size: 20, color: MyColors.black),
          ),

          SizedBox(width: 2.w),

          /// ✅ Remove Icon
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              item.status == 'rejected'
                  ? Icons.delete_outline_rounded
                  : Icons.remove_circle_outline_rounded,
              size: 20,
              color: item.status == 'rejected' ? MyColors.red : MyColors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildStatusBadge() {
    switch (item.status) {
      case "pending":
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: MyColors.golden),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: MyColors.golden, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              const Text(
                "Not viewed",
                style: TextStyle(fontSize: 11, color: MyColors.golden, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );

      case "accepted":
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: MyColors.primary),
          ),
          child: const Text(
            "Message",
            style: TextStyle(fontSize: 11, color: MyColors.primary, fontWeight: FontWeight.w500),
          ),
        );

      case "rejected":
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: MyColors.red),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: MyColors.red, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              const Text(
                "Rejected",
                style: TextStyle(fontSize: 11, color: MyColors.red, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
    }
    return null;
  }
}
