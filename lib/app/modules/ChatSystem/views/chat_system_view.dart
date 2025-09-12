import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/controllers/chat_system_controller.dart';

class ChatSystemView extends GetView<ChatSystemController> {
  const ChatSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    const String timeStamp = '12 May 2025,09:12 am';

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      resizeToAvoidBottomInset: true, // ✅ Allows body to resize when keyboard opens
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.fontBlack, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Support",
          style: MyTexts.light22.copyWith(color: MyColors.textFieldBackground),
        ),
      ),
      body: Stack(
        children: [
          // Full screen background color
          Container(color: MyColors.backgroundColor),

          // White rounded-top container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  reverse: true,

                  child: Column(
                    children: [
                      // Messages area
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const SizedBox(), // Replace with actual messages
                      ),

                      // Selection chips and expandable tiles
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select your issue to proceed",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildChip(
                                    label: 'Profile Details',
                                    color: MyColors.aquacolor,
                                    borderColor: MyColors.faneuilBrick,
                                  ),
                                  SizedBox(width: 2.w),
                                  _buildChip(
                                    label: 'Product Details',
                                    color: const Color(0xFFE6F4FF),
                                  ),
                                  SizedBox(width: 2.w),
                                  _buildChip(
                                    label: 'XYZ',
                                    color: const Color(0xFFFFF0E5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "What help do you need for Profile:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildExpandableTile(
                              title: "Profile Updation",
                              isExpanded: controller.profileUpdation,
                              onTap: () =>
                                  controller.toggleTile(controller.profileUpdation),
                            ),
                            _buildExpandableTile(
                              title: "Profile Approval Status",
                              isExpanded: controller.profileApproval,
                              onTap: () =>
                                  controller.toggleTile(controller.profileApproval),
                            ),
                            _buildExpandableTile(
                              title: "Profile Deletion",
                              isExpanded: controller.profileDeletion,
                              onTap: () =>
                                  controller.toggleTile(controller.profileDeletion),
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),

                      // Chat bubbles section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // First Message (Left)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(Asset.profil),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD8E6FF),
                                      borderRadius: BorderRadius.circular(27),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "We have received your request and are processing it",
                                          style: MyTexts.regular16.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          timeStamp,
                                          style: MyTexts.regular12.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),

                            // Second Message (Right)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 164,
                                    height: 92,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(27),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Thank You!",
                                          style: MyTexts.regular16.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          timeStamp,
                                          style: MyTexts.regular12.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(Asset.profil),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Input section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: MyColors.brightGray,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Type here...",
                                    border: InputBorder.none,
                                  ),
                                  style: MyTexts.regular16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 1.w),
                            Container(
                              decoration: const BoxDecoration(
                                color: MyColors.progressRemaining,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  Asset.supportView,
                                  width: 24,
                                  height: 24,
                                ),
                                onPressed: () {
                                  // handle file attach action
                                },
                              ),
                            ),
                            SizedBox(width: 1.w),
                            Container(
                              decoration: const BoxDecoration(
                                color: MyColors.progressRemaining,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.mic, color: MyColors.fontBlack),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({required String label, required Color color, Color? borderColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Text(label, style: MyTexts.regular14.copyWith(color: MyColors.fontBlack)),
    );
  }

  Widget _buildExpandableTile({
    required String title,
    required RxBool isExpanded,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: MyColors.brightGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.add, color: MyColors.fontBlack, size: 12),
                const SizedBox(width: 6),
                Text(title, style: MyTexts.regular16.copyWith(color: MyColors.fontBlack)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
