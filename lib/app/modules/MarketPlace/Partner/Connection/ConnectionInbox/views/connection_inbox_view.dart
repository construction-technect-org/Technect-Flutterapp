import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/components/connection_dialogs.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/model/connectionModel.dart';
import 'package:gap/gap.dart';

class ConnectionInboxView extends StatelessWidget {
  final ConnectionInboxController controller = Get.put(
    ConnectionInboxController(),
  );

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
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.loginBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
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
                            child: CircularProgressIndicator(
                              color: MyColors.primary,
                            ),
                          );
                        } else if (controller.filteredConnections.isEmpty) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.searchQuery.value.isNotEmpty
                                        ? 'No connections found'
                                        : 'No connection requests',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    controller.searchQuery.value.isNotEmpty
                                        ? 'Try searching with different keywords'
                                        : 'Connection requests will appear here',
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.grey,
                                      fontFamily: MyTexts.SpaceGrotesk,
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
                                    borderRadius: BorderRadius.circular(16),
                                    color: MyColors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: MyColors.grayEA,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: myPref.role.val == "connector"
                                      ? buildConnector(connection, context)
                                      : buildPartner(connection, context),
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
            ],
          ),
        ),
      ),
    );
  }

  Stack buildConnector(Connection connection, BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: MyColors.grey,
                    radius: 18,
                    child: connection.connectorProfileImageUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  APIConstants.bucketUrl +
                                  connection.connectorProfileImageUrl!,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const ColoredBox(
                                color: MyColors.lightGray,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.person, color: MyColors.white),
                            ),
                          )
                        : Icon(Icons.person, color: MyColors.white),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.connectorName ?? 'Unknown',
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
                              colorFilter: const ColorFilter.mode(
                                MyColors.gra54,
                                BlendMode.srcIn,
                              ),
                              height: 14,
                              width: 14,
                            ),
                            const Gap(4),
                            Text(
                              connection.merchantName ?? 'Unknown',
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gra54,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ],
                        ),
                        const Gap(8),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                status: connection.status ?? "",
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              connection.status?.capitalizeFirst ?? "",
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gra54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (connection.status == "accepted") const Gap(12),
                  if (connection.status == "accepted")
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) =>
                              ChatBottomSheet(connection: connection),
                        );
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grayEA.withValues(alpha: 0.32),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(Asset.chat),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
        if (connection.status?.toLowerCase() == "accepted")
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
                  TextSpan(
                    text: timeAgo(connection.connectedAt),
                    style: MyTexts.medium13.copyWith(color: MyColors.gra54),
                  ),
                ],
              ),
            ),
          ),
      ],
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

  Stack buildPartner(Connection connection, BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: MyColors.grey,
                    radius: 18,
                    child: connection.connectorProfileImageUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  APIConstants.bucketUrl +
                                  connection.connectorProfileImageUrl!,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const ColoredBox(
                                color: MyColors.lightGray,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.person, color: MyColors.white),
                            ),
                          )
                        : Icon(Icons.person, color: MyColors.white),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.connectorName ?? 'Unknown',
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
                              colorFilter: const ColorFilter.mode(
                                MyColors.gra54,
                                BlendMode.srcIn,
                              ),
                              height: 14,
                              width: 14,
                            ),
                            const Gap(4),
                            Text(
                              connection.merchantName ?? 'Unknown',
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gra54,
                                fontFamily: MyTexts.SpaceGrotesk,
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
                                  ConnectionDialogs.showAcceptConnectionDialog(
                                    context,
                                    connection,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColors.greenBtn,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Connect",
                                    style: MyTexts.medium13.copyWith(
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(16),
                              GestureDetector(
                                onTap: () {
                                  ConnectionDialogs.showRejectConnectionDialog(
                                    context,
                                    connection,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Disconnect",
                                    style: MyTexts.medium13.copyWith(
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                status: connection.status ?? "",
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              connection.status?.capitalizeFirst ?? "",
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gra54,
                              ),
                            ),
                          ),
                        ],
                        const Gap(10),
                      ],
                    ),
                  ),
                  if (connection.status == "accepted") const Gap(12),
                  if (connection.status == "accepted")
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) =>
                              ChatBottomSheet(connection: connection),
                        );
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grayEA.withValues(alpha: 0.32),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(Asset.chat),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
        if (connection.status?.toLowerCase() == "accepted")
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
                  TextSpan(
                    text: timeAgo(connection.connectedAt),
                    style: MyTexts.medium13.copyWith(color: MyColors.gra54),
                  ),
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
    final TextEditingController messageController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: MyColors.grey,
                  backgroundImage: connection.connectorProfileImageUrl != null
                      ? CachedNetworkImageProvider(
                          APIConstants.bucketUrl +
                              connection.connectorProfileImageUrl!,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    connection.connectorName ?? "Unknown",
                    style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                  ),
                ),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    if (value == 'remove') {
                      ConnectionDialogs.showRemoveConnectionDialog(
                        context,
                        connection,
                      );
                    } else if (value == 'block') {
                      ConnectionDialogs.showBlockDialog(context, connection);
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
                          Text(
                            'Block',
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.red,
                            ),
                          ),
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

            // Chat Messages
            Expanded(
              child: ListView(
                children: const [
                  ChatBubble(
                    isSender: false,
                    text:
                        "Hi, I’m interested in the OPC 43 Grade Cement you listed. Is it available in bulk?",
                  ),
                  ChatBubble(
                    isSender: true,
                    text:
                        "Hello! Yes, we have OPC 43 Grade in stock. How much quantity are you looking for?",
                  ),
                  ChatBubble(
                    isSender: false,
                    text:
                        "I need around 500 bags for a site in Bangalore. What’s the best price you can offer?",
                  ),
                  ChatBubble(
                    isSender: true,
                    text:
                        "For 500 bags, we can offer ₹310 per bag. Delivery charges depend on location.",
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: MyColors.primary,
                              size: 60,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Feature Available in CRM",
                              style: MyTexts.extraBold16.copyWith(
                                color: MyColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "To use this chat feature, please move to the CRM section.",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.dopelyColors,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.h),
                            RoundedButton(
                              buttonName: "Go to CRM",
                              onTap: () {
                                Navigator.pop(context);
                              },
                              color: MyColors.primary,
                              height: 45,
                              borderRadius: 12,
                            ),
                            SizedBox(height: 1.h),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: MyColors.dopelyColors),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      child: CommonTextField(
                        controller: messageController,
                        hintText: 'Start typing...',
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Icon(Icons.send_rounded, color: MyColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String text;

  const ChatBubble({Key? key, required this.isSender, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFFE8F0FE) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
        ),
      ),
    );
  }
}
