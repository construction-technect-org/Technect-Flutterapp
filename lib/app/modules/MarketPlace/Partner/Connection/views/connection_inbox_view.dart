import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_permission_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/model/connectionModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/incoming_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/outgoing_model.dart';

class ConnectionInboxView extends StatelessWidget {
  final ConnectionInboxController controller = Get.put(ConnectionInboxController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> connectionList = [
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "status": ConnectionStatus.notViewed,
      },
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "status": ConnectionStatus.message,
      },
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "status": ConnectionStatus.rejected,
      },
    ];
    final List<Map<String, dynamic>> receivedList = [
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "timeAgo": "2 hr",
        "status": ReceivedStatus.pending,
      },
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "timeAgo": "2 hr",
        "status": ReceivedStatus.pending,
      },
      {
        "name": "Full Name",
        "designation": "Designation",
        "imageUrl": "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
        "timeAgo": "22nd Jan 2026",
        "status": ReceivedStatus.pending,
      },
    ];
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
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
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
                                    onBlock: () {
                                      ConnectionDialogs.showBlockDialog(
                                        context,
                                        item,
                                        "Block",
                                        Icons.block,
                                      );
                                    },
                                    onReject: () {
                                      ConnectionDialogs.showBlockDialog(
                                        context,
                                        item,
                                        "Decline",
                                        Icons.clear,
                                      );
                                    },
                                    onAccept: () {
                                      ConnectionDialogs.showRemoveConnectionDialog(
                                        context,
                                        item,
                                        "Accept",
                                        Icons.check_rounded,
                                      );
                                    },
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
                                    onBlock: () {
                                      ConnectionDialogs.showBlockDialogOutgoing(
                                        context,
                                        item,
                                        "Block",
                                        Icons.block,
                                      );
                                    },
                                    onRemove: () {
                                      ConnectionDialogs.showBlockDialogOutgoing(
                                        context,
                                        item,
                                        "Withdraw",
                                        Icons.remove_circle_outline,
                                      );
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

  Text buildConnector(Connection connection, BuildContext context) {
    return const Text("Rohit");
    // return Stack(
    //   alignment: AlignmentGeometry.bottomRight,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(12),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               CircleAvatar(
    //                 backgroundColor: MyColors.grey,
    //                 radius: 18,
    //                 child: connection.merchantProfileImageUrl != null
    //                     ? ClipOval(
    //                         child: CachedNetworkImage(
    //                           imageUrl:
    //                               APIConstants.bucketUrl + connection.merchantProfileImageUrl!,
    //                           width: 36,
    //                           height: 36,
    //                           fit: BoxFit.cover,
    //                           placeholder: (context, url) => const ColoredBox(
    //                             color: MyColors.lightGray,
    //                             child: Center(child: CircularProgressIndicator()),
    //                           ),
    //                           errorWidget: (context, url, error) =>
    //                               Icon(Icons.person, color: MyColors.white),
    //                         ),
    //                       )
    //                     : Icon(Icons.person, color: MyColors.white),
    //               ),
    //               const Gap(12),
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       connection.merchantName ?? 'Unknown',
    //                       style: MyTexts.medium16.copyWith(
    //                         color: MyColors.fontBlack,
    //                         fontFamily: MyTexts.SpaceGrotesk,
    //                       ),
    //                     ),
    //                     const Gap(2),
    //                     Row(
    //                       children: [
    //                         SvgPicture.asset(
    //                           Asset.location,
    //                           colorFilter: const ColorFilter.mode(MyColors.gra54, BlendMode.srcIn),
    //                           height: 14,
    //                           width: 14,
    //                         ),
    //                         const Gap(4),
    //                         Expanded(
    //                           child: Text(
    //                             connection.merchantAddress ?? "Unknown",
    //                             maxLines: 2,
    //                             style: MyTexts.medium13.copyWith(
    //                               color: MyColors.gra54,
    //                               fontFamily: MyTexts.SpaceGrotesk,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const Gap(8),
    //                     Container(
    //                       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
    //                       decoration: BoxDecoration(
    //                         color: getStatusColor(status: connection.status ?? ""),
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Text(
    //                         connection.status?.capitalizeFirst ?? "",
    //                         style: MyTexts.medium13.copyWith(color: MyColors.gra54),
    //                       ),
    //                     ),
    //                     const Gap(10),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 1.h),
    //         ],
    //       ),
    //     ),
    //     if (connection.status?.toLowerCase() == "accepted")
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //         decoration: const BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(32),
    //             bottomLeft: Radius.circular(32),
    //             bottomRight: Radius.circular(16),
    //           ),
    //           color: MyColors.grayE6,
    //         ),
    //         child: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 text: "Connected  ",
    //                 style: MyTexts.medium13.copyWith(color: MyColors.grayA5),
    //               ),
    //               TextSpan(
    //                 text: timeAgo(connection.connectedAt),
    //                 style: MyTexts.medium13.copyWith(color: MyColors.gra54),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //   ],
    // );
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

  Stack buildPartner(Connection connection, BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundColor: MyColors.grey,
              //   radius: 18,
              //   child: connection.connectorProfileImageUrl != null
              //       ? ClipOval(
              //           child: CachedNetworkImage(
              //             imageUrl: APIConstants.bucketUrl + connection.connectorProfileImageUrl!,
              //             width: 36,
              //             height: 36,
              //             fit: BoxFit.cover,
              //             placeholder: (context, url) => const ColoredBox(
              //               color: MyColors.lightGray,
              //               child: Center(child: CircularProgressIndicator()),
              //             ),
              //             errorWidget: (context, url, error) =>
              //                 Icon(Icons.person, color: MyColors.white),
              //           ),
              //         )
              //       : Icon(Icons.person, color: MyColors.white),
              // ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "connection.connectorName",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Asset.location,
                          colorFilter: const ColorFilter.mode(MyColors.gra54, BlendMode.srcIn),
                          height: 14,
                          width: 14,
                        ),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            "connection.connectorAddress",
                            maxLines: 2,
                            style: MyTexts.medium13.copyWith(
                              color: MyColors.gra54,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    if (connection.status == "pending") ...[
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ConnectionDialogs.showAcceptConnectionDialog(context, connection);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                              decoration: BoxDecoration(
                                color: MyColors.greenBtn,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Connect",
                                style: MyTexts.medium13.copyWith(color: MyColors.white),
                              ),
                            ),
                          ),
                          const Gap(16),
                          GestureDetector(
                            onTap: () {
                              ConnectionDialogs.showRejectConnectionDialog(context, connection);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                              decoration: BoxDecoration(
                                color: MyColors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Disconnect",
                                style: MyTexts.medium13.copyWith(color: MyColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                        decoration: BoxDecoration(
                          color: getStatusColor(status: connection.status ?? ""),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          connection.status.capitalizeFirst ?? "",
                          style: MyTexts.medium13.copyWith(color: MyColors.gra54),
                        ),
                      ),
                    ],
                    const Gap(10),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (connection.status.toLowerCase() == "accepted")
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(16),
              ),
              color: MyColors.grayE6,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Connected  ",
                    style: MyTexts.medium13.copyWith(color: MyColors.grayA5),
                  ),
                  // TextSpan(
                  //   text: timeAgo(connection.connectedAt),
                  //   style: MyTexts.medium13.copyWith(color: MyColors.gra54),
                  // ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Color getStatusColor({required String status}) {
    if (status == "pending") {
      return const Color(0xFFFDEBC8);
    } else if (status == "accepted") {
      return MyColors.grayEA;
    } else if (status == "rejected") {
      return const Color(0xFFFCECE9);
    }
    return MyColors.grayEA;
  }
}

class ChatBottomSheet extends StatelessWidget {
  final Connection connection;

  const ChatBottomSheet({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 20,
                //   backgroundColor: MyColors.grey,
                //   backgroundImage: connection.connectorProfileImageUrl != null
                //       ? CachedNetworkImageProvider(
                //           APIConstants.bucketUrl + connection.connectorProfileImageUrl!,
                //         )
                //       : null,
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "connection.connectorName",
                    style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                  ),
                ),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onSelected: (value) {
                    if (value == 'remove') {
                      // ConnectionDialogs.showRemoveConnectionDialog(context, connection);
                    } else if (value == 'block') {
                      // ConnectionDialogs.showBlockDialog(context, connection, "Block");
                    }
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          SvgPicture.asset(Asset.removeC),
                          const Gap(4),
                          Text('Remove Connection', style: MyTexts.medium14),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'block',
                      child: Row(
                        children: [
                          SvgPicture.asset(Asset.block),
                          const Gap(4),
                          Text('Block', style: MyTexts.medium14.copyWith(color: MyColors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.grayEA),
                    ),
                    child: const Icon(Icons.more_horiz, color: MyColors.gra54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildRow(title: "Quotation ID", data: "QT-2025-008"),
                  const Gap(8),
                  buildRow(title: "Date Issued", data: "QT-2025-008"),
                  const Gap(8),

                  buildRow(title: "Client Name", data: "QT-2025-008"),
                  const Gap(8),

                  buildRow(title: "Quotation ID", data: "QT-2025-008"),
                ],
              ),
            ),
            const Gap(16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Hi, I'm interested in the OPC 43 Grade Cement\n you listed. Is it available in bulk?",
                    style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                    textAlign: TextAlign.right,
                  ),
                  const Gap(16),
                  RoundedButton(buttonName: "Connect CRM", onTap: () {}, width: 160),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow({required String title, required String data}) {
    return Row(
      children: [
        Text(title, style: MyTexts.medium14.copyWith(color: MyColors.gray54)),
        const Spacer(),
        Text(data, style: MyTexts.medium15.copyWith(color: MyColors.gray2E)),
      ],
    );
  }
}

class SentCard extends StatelessWidget {
  final Connection item;

  const SentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Get.find<ConnectionInboxController>().withdrawRequest(item.id ?? "");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: Colors.grey.shade200, width: 0.3),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Row
            const Row(
              children: [
                // CircleAvatar(
                //   radius: 22,
                //   backgroundImage: NetworkImage(item.image ?? ""),
                // ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "House owner / other",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Jp nagar 7th phase rbi layout",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                /// Connect Sent Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff1E2A78),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.status == "withdrawn" ? item.status : "Connect Sent",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                const Spacer(),

                /// Time Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Connected 2h ago", style: TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReceivedCard extends StatelessWidget {
  final IncomingConnection item;

  const ReceivedCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.grey.shade200, width: 0.3),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile Row
          const Row(
            children: [
              // CircleAvatar(
              //   radius: 22,
              //   backgroundImage: NetworkImage(item.image ?? ""),
              // ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "House owner / other",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Jp nagar 7th phase rbi layout",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Accept
              if (item.status == "pending") ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // ConnectionDialogs.showRemoveConnectionDialog(context, item);
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Accept", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7),

                /// Decline
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // ConnectionDialogs.showBlockDialog(context, item, "Decline");
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Decline", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // ConnectionDialogs.showBlockDialog(context, item, "Block");
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Block", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text("Connected", style: TextStyle(fontSize: 11))),
                  ),
                ),
                const SizedBox(width: 7),

                /// Remove
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // ConnectionDialogs.showBlockDialog(context, item, "Remove");
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Remove", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(width: 10),

              /// Time Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("2h ago", style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum ReceivedStatus { pending, accepted, rejected }

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
                    Text(
                      item.connectorProfile?.verificationDetails?.name ?? "NA",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
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

enum ConnectionStatus { notViewed, message, rejected }

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
                    Text(
                      item.merchantProfile?.businessName ?? "N/A",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
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
          ?_buildStatusBadge(),

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
              item.status == ConnectionStatus.rejected
                  ? Icons.delete_outline_rounded
                  : Icons.remove_circle_outline_rounded,
              size: 20,
              color: item.status == ConnectionStatus.rejected ? MyColors.red : MyColors.red,
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
