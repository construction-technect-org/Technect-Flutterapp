import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/show_switch_account_bottomsheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/switchAccount/switch_account_controller.dart';

import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildCategorySelector(),
          Expanded(child: _buildProjectsList()),
        ],
      ),
      bottomNavigationBar: const ProjectsBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text("Projects", style: MyTexts.medium20.copyWith(color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              // 1. Search Bar
              Expanded(
                flex: 4,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 20),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      Icon(Icons.tune, color: Colors.grey.shade400, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // 2. Radius Button
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.map_outlined, size: 18, color: Colors.blueGrey.shade400),
                    const SizedBox(width: 4),
                    const Text(
                      "5km",
                      style: TextStyle(
                        color: Color(0xFF1B2F62),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // 3. View Toggle Button
              Obx(
                () => GestureDetector(
                  onTap: () => controller.isGridView.toggle(),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Icon(
                      controller.isGridView.value
                          ? Icons.grid_view_rounded
                          : Icons.format_list_bulleted_rounded,
                      color: const Color.fromARGB(255, 253, 209, 86),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 4),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == index;
            return GestureDetector(
              onTap: () => controller.selectedCategory.value = index,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: isSelected
                            ? const DecorationImage(
                                image: AssetImage(Asset.activeCategoryBg),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center,
                                scale: 1,
                              )
                            : null,
                        // color: isSelected ? Colors.transparent : Colors.grey.shade100,
                        // borderRadius: isSelected ? null : BorderRadius.circular(15),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          category['image']!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    category['name']!,
                    style: MyTexts.medium13.copyWith(
                      color: isSelected ? const Color(0xFF1B2F62) : Colors.grey.shade600,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildProjectsList() {
    return Obx(() {
      final isManufacturer = controller.selectedCategory.value == 1;
      final data = isManufacturer ? controller.manufacturers : controller.projects;

      if (controller.isGridView.value) {
        return _buildProjectsGrid(data, isManufacturer);
      } else {
        return _buildProjectsVerticalList(data, isManufacturer);
      }
    });
  }

  Widget _buildProjectsVerticalList(List<Map<String, dynamic>> data, bool isManufacturer) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildProjectCard(item);
      },
    );
  }

  Widget _buildProjectsGrid(List<Map<String, dynamic>> data, bool isManufacturer) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.66,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildProjectGridItem(item);
      },
    );
  }

  Widget _buildProjectGridItem(Map<String, dynamic> project) {
    final bool isManufacturer = project.containsKey('category');
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              isManufacturer ? project['name'] ?? "" : project['projectName'] ?? "",
              style: MyTexts.medium14.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ClipRRect(
            child: Image.asset(
              project['projectImage'] ?? Asset.explore,
              width: double.infinity,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const CircleAvatar(radius: 8, backgroundImage: AssetImage(Asset.profil)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['connectorName'] ?? "",
                            style: MyTexts.medium14.copyWith(color: Colors.black87, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 1),
                          Text(
                            project['location'] ?? "",
                            style: MyTexts.regular12.copyWith(
                              color: const Color(0xFF1B2F62).withOpacity(0.6),
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(height: 1, color: Color.fromARGB(255, 205, 205, 205)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      isManufacturer ? Icons.category_outlined : Icons.grid_view_outlined,
                      size: 14,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        isManufacturer ? "${project['category']}" : "${project['area']} sqft",
                        style: MyTexts.medium12.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.near_me_outlined, size: 14, color: Colors.grey.shade400),
                        const SizedBox(width: 4),
                        Text(
                          "${project['distance']} km",
                          style: MyTexts.medium12.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.PROJECT_DETAIL),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF1B2F62)),
                    ),
                    child: Center(
                      child: Text(
                        "Connect",
                        style: MyTexts.medium12.copyWith(
                          color: const Color(0xFF1B2F62),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    final bool isManufacturer = project.containsKey('category');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isManufacturer ? project['name'] ?? "" : project['projectName'] ?? "",
            style: MyTexts.medium14.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  project['projectImage'] ?? Asset.explore,
                  width: 80,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    const CircleAvatar(radius: 14, backgroundImage: AssetImage(Asset.profil)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['connectorName'] ?? "",
                            style: MyTexts.medium14.copyWith(color: Colors.black87),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            project['location'] ?? "",
                            style: MyTexts.regular12.copyWith(
                              color: const Color(0xFF1B2F62).withOpacity(0.6),
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: Color.fromARGB(255, 205, 205, 205)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isManufacturer ? Icons.category_outlined : Icons.grid_view_outlined,
                size: 16,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: 4),
              Text(
                isManufacturer ? "${project['category']}" : "${project['area']} sqft",
                style: MyTexts.medium12.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Icon(Icons.near_me_outlined, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(
                "${project['distance']} km",
                style: MyTexts.medium12.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _buildConnectButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PROJECT_DETAIL),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1B2F62)),
        ),
        child: Text(
          "Connect",
          style: MyTexts.medium12.copyWith(
            color: const Color(0xFF1B2F62),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProjectsBottomNavBar extends StatelessWidget {
  const ProjectsBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonController commonController = Get.find<CommonController>();
    final isConnector = myPref.role.val == "connector";

    return Container(
      height: 100,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(100.w, 100),
            painter: ProjectsBNBPainter(),
            child: Container(
              height: 100,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: isConnector
                    ? [
                        _buildNavItem(
                          Asset.home,
                          Asset.home1,
                          "Home",
                          isSelected: false,
                          onTap: () => Get.offAllNamed(Routes.MAIN, arguments: {'index': 0}),
                        ),
                        _buildNavItem(
                          Asset.category,
                          Asset.category1,
                          "Category",
                          isSelected: true,
                        ),
                        const SizedBox(width: 40),
                        _buildNavItem(Asset.setting, Asset.setting, "Manage", isSelected: false),
                        _buildNavItem(
                          Asset.connection,
                          Asset.connection1,
                          "Connect",
                          isSelected: false,
                        ),
                      ]
                    : [
                        _buildNavItem(
                          Asset.home,
                          Asset.home1,
                          "Home",
                          isSelected: false,
                          onTap: () => Get.back(),
                        ),
                        _buildNavItem(
                          Asset.category,
                          Asset.category1,
                          "Category",
                          isSelected: true,
                        ),
                        const SizedBox(width: 40),
                        _buildNavItem(Asset.setting, Asset.setting, "Manage", isSelected: false),
                        _buildNavItem(
                          Asset.connection,
                          Asset.connection1,
                          "Connect",
                          isSelected: false,
                        ),
                      ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            child: GestureDetector(
              onTap: () async {
                await commonController.fetchProfileDataM();
                Get.put<SwitchAccountController>(SwitchAccountController());
                showSwitchAccountBottomSheet();
              },
              child: Container(
                width: 65,
                height: 115,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B4F92), Color(0xFF1B2F62)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withOpacity(0.3), spreadRadius: 4, blurRadius: 8),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.sync, color: Colors.white, size: 24),
                    Text(
                      "Switch",
                      style: MyTexts.medium10.copyWith(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    String icon2,
    String label, {
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSelected ? icon2 : icon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? const Color(0xFF1B2F62) : const Color(0xFF555555),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: MyTexts.medium14.copyWith(
              color: isSelected ? const Color(0xFF1B2F62) : const Color(0xFF555555),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsBNBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MyColors.tertiary
      ..style = PaintingStyle.fill;

    double cornerRadius = 40.0;
    double notchWidth = 80.0;
    double topY = 25.0;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, topY + cornerRadius);
    path.quadraticBezierTo(0, topY, cornerRadius, topY); // Top-left rounded edge

    path.lineTo(size.width / 2 - notchWidth / 2 - 12, topY);

    // Smooth transition into the notch
    path.quadraticBezierTo(
      size.width / 2 - notchWidth / 2,
      topY,
      size.width / 2 - notchWidth / 2,
      topY + 8,
    );

    // The notch circle cutout
    path.arcToPoint(
      Offset(size.width / 2 + notchWidth / 2, topY + 8),
      radius: Radius.circular(notchWidth / 2.2),
      clockwise: false,
    );

    // Smooth transition out of the notch
    path.quadraticBezierTo(
      size.width / 2 + notchWidth / 2,
      topY,
      size.width / 2 + notchWidth / 2 + 12,
      topY,
    );

    path.lineTo(size.width - cornerRadius, topY);
    path.quadraticBezierTo(
      size.width,
      topY,
      size.width,
      topY + cornerRadius,
    ); // Top-right rounded edge

    path.lineTo(size.width, size.height);

    // Bottom edge with center curve
    path.lineTo(size.width / 2 + notchWidth / 2 + 20, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 15,
      size.width / 2 - notchWidth / 2 - 20,
      size.height,
    );

    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 8, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
