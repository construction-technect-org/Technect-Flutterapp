import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/bindings/profile_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/views/profile_view.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonController commonController = Get.find<CommonController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        final user = commonController.profileData.value.data?.user;
        final name = user?.fullName.isNotEmpty == true ? user!.fullName : "Full Name";
        final email = user?.email ?? "Fullname@gmail.com";
        final roleName = user?.roleName ?? "Designation";
        final imageUrl = user?.image;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Profile Header ───────────────────────────
              _buildProfileHeader(name, email, roleName, imageUrl),
              const SizedBox(height: 8),

              // ─── Account ──────────────────────────────────
              _buildSectionLabel("Account"),
              _buildMenuItem(
                icon: Icons.manage_accounts_outlined,
                label: "Manage Profile",
                onTap: () {
                  Get.to(() => ProfileView(), binding: ProfileBinding());
                },
              ),
              _buildMenuItem(
                icon: Icons.group_outlined,
                label: "Teams",
                onTap: () => Get.toNamed(Routes.ROLE_MANAGEMENT),
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                label: "Accounts & Password",
                onTap: () => Get.toNamed(Routes.ACCOUNT),
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                label: "Shipping Location",
                onTap: () => Get.toNamed(Routes.MANUFACTURER_ADDRESS),
              ),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                label: "Notifications",
                onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
              ),

              const SizedBox(height: 8),

              // ─── Preferences ──────────────────────────────
              _buildSectionLabel("Preferences"),
              _buildMenuItem(
                icon: Icons.list_alt_outlined,
                label: "Your Activity",
                onTap: () => Get.toNamed(Routes.APPROVAL_INBOX),
              ),
              _buildMenuItem(
                icon: Icons.bar_chart_outlined,
                label: "Report",
                onTap: () => Get.toNamed(Routes.REPORT, arguments: {"isReport": true}),
              ),
              _buildMenuItem(
                icon: Icons.inventory_2_outlined,
                label: "Inventory",
                onTap: () => Get.toNamed(Routes.INVENTORY),
              ),
              _buildMenuItem(
                icon: Icons.play_circle_outline,
                label: "Tutorials",
                onTap: () => Get.toNamed(Routes.FAQ),
              ),
              _buildMenuItem(
                icon: Icons.chat_bubble_outline,
                label: "Feedback",
                onTap: () => Get.toNamed(Routes.FEEDBACK_VIEW),
              ),

              const SizedBox(height: 8),

              // ─── Support ──────────────────────────────────
              _buildSectionLabel("Support"),
              _buildMenuItem(icon: Icons.info_outline, label: "About Us", onTap: () {}),
              _buildMenuItem(
                icon: Icons.help_outline,
                label: "F.A.Q'S",
                onTap: () => Get.toNamed(Routes.FAQ),
              ),
              _buildMenuItem(
                icon: Icons.article_outlined,
                label: "News",
                onTap: () => Get.toNamed(Routes.NEWS),
              ),
              _buildMenuItem(
                icon: Icons.card_giftcard_outlined,
                label: "Refer & Earn",
                onTap: () => Get.toNamed(Routes.REFER_EARN),
              ),
              _buildMenuItem(
                icon: Icons.headset_mic_outlined,
                label: "Help Center",
                onTap: () => Get.toNamed(Routes.SUPPORT_REQUEST),
              ),
              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                label: "Privacy Policy",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.description_outlined,
                label: "Terms & Conditions",
                onTap: () {},
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 56,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
        onPressed: () => Get.back(),
      ),
      title: Text(
        "My Profile",
        style: MyTexts.medium18.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader(String name, String email, String roleName, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          _buildAvatar(imageUrl),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: MyTexts.bold18.copyWith(color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified_outlined, size: 18, color: Color(0xFF1B2F62)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(roleName, style: MyTexts.regular14.copyWith(color: Colors.grey.shade600)),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: MyTexts.regular14.copyWith(color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD4AF37), width: 2.5),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(imageUrl, fit: BoxFit.cover)
            : Image.asset(Asset.profil, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      child: Text(label, style: MyTexts.regular14.copyWith(color: Colors.grey.shade500)),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 22, color: Colors.black87),
              const SizedBox(width: 16),
              Expanded(
                child: Text(label, style: MyTexts.regular14.copyWith(color: Colors.black87)),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
