import 'package:construction_technect/app/core/utils/imports.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(Asset.menuIcon, width: 24, height: 24),
        ),
        title: Text('Menu', style: MyTexts.regular20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.sw),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildMenuItem('Product Management', false),
            SizedBox(height: 1.h),
            _buildMenuItem('Approval Inbox', true),
            SizedBox(height: 1.h),
            _buildMenuItem('Role Management', false),
            SizedBox(height: 1.h),
            _buildMenuItem('Support Ticket', true),
            SizedBox(height: 1.h),
            _buildMenuItem(
              'Settings',
              false,
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    bool hasNotification, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.menuTile,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  Asset.menuSettingIcon,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    MyColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: MyTexts.medium16.copyWith(color: MyColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
