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
                  // Tab Bar
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 18.0,
                      right: 18.0,
                    ),
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: MyColors.grayEA,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.onTabChanged(0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedTabIndex.value == 0
                                        ? MyColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'All',
                                    textAlign: TextAlign.center,
                                    style: MyTexts.medium14.copyWith(
                                      color:
                                          controller.selectedTabIndex.value == 0
                                          ? Colors.white
                                          : MyColors.gray54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.onTabChanged(1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedTabIndex.value == 1
                                        ? MyColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Product',
                                    textAlign: TextAlign.center,
                                    style: MyTexts.medium14.copyWith(
                                      color:
                                          controller.selectedTabIndex.value == 1
                                          ? Colors.white
                                          : MyColors.gray54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.onTabChanged(2),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedTabIndex.value == 2
                                        ? MyColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Services',
                                    textAlign: TextAlign.center,
                                    style: MyTexts.medium14.copyWith(
                                      color:
                                          controller.selectedTabIndex.value == 2
                                          ? Colors.white
                                          : MyColors.gray54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
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
                                  // Get.toNamed(Routes.CONNECTION_INBOX);
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Expanded(
                              child: Text(
                                connection.productName != null
                                    ? connection.productName ?? 'Unknown'
                                    : connection.serviceName ?? 'Unknown',
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
        // Item Type Badge (top right) - only show when "All" tab is selected
        Obx(
          () => controller.selectedTabIndex.value == 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (connection.itemType?.toLowerCase() == 'service')
                          ? MyColors.primary
                          : MyColors.greenBtn,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      (connection.itemType?.toLowerCase() == 'service')
                          ? 'Service'
                          : 'Product',
                      style: MyTexts.medium12.copyWith(
                        color: Colors.white,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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
                            Expanded(
                              child: Text(
                                connection.productName != null
                                    ? connection.productName ?? 'Unknown'
                                    : connection.serviceName ?? 'Unknown',
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
        // Item Type Badge (top right) - only show when "All" tab is selected
        Obx(
          () => controller.selectedTabIndex.value == 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (connection.itemType?.toLowerCase() == 'service')
                          ? MyColors.primary
                          : MyColors.greenBtn,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      (connection.itemType?.toLowerCase() == 'service')
                          ? 'Service'
                          : 'Product',
                      style: MyTexts.medium12.copyWith(
                        color: Colors.white,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
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
                  RoundedButton(
                    buttonName: "Connect CRM",
                    onTap: () {},
                    width: 160,
                  ),
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
