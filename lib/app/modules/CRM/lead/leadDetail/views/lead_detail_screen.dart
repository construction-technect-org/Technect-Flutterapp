import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/CRM/lead/leadDetail/controller/lead_detail_controller.dart';

class LeadDetailScreen extends GetView<LeadDetailController> {
  const LeadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  isCenter: false,
                  title: const Text("Lead Details"),
                  leading: GestureDetector(
                    onTap: Get.back,
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topLeadCard(),
                          const Gap(16),
                          Text("Status", style: MyTexts.medium16),
                          const Gap(9),
                          CommonDropdown(
                            hintText: "Select lead status",
                            items: const ["Follow Up", "Pending"],
                            selectedValue: controller.selectedCustomerType,
                            enabled: false,
                            itemLabel: (item) => item,
                            validator: (val) => val == null ? "Select status" : null,
                          ),
                          const Gap(20),
                          Text("Status Pipeline Representation", style: MyTexts.medium16),
                          const Gap(20),
                          _pipelineSection(),
                          const Gap(28),
                          _followUpSection(),
                          const Gap(24),
                          _requirementSection(),
                          const Gap(24),
                          _conversationSection(),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _topLeadCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayD6),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFFF3F8FF), Color(0xFFE7F0FF)]),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: getImageView(
              finalUrl: "https://picsum.photos/200/300",
              height: 114,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),

          /// TEXT AREA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Lead Id - #CT01256",
                        style: MyTexts.medium14.copyWith(color: Colors.black),
                      ),
                    ),
                    Text("10:30 AM, Nov 12", style: MyTexts.medium10.copyWith(color: Colors.black)),
                  ],
                ),
                const Gap(5),
                Text("Buyer Details -", style: MyTexts.regular14),
                const Gap(3),
                Text("POC Phone Number", style: MyTexts.regular14),
                const Gap(3),
                Text("POC Name -", style: MyTexts.regular14),
                const Gap(3),
                Text("Product Name -", style: MyTexts.regular14),
                const Gap(3),
                Text("Quantity -", style: MyTexts.regular14.copyWith(color: MyColors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipelineSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayEA),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _pipelineTile("45", "Leads", const Color(0xFFF9D0CB)),
          _pipelineTile("23", "Followup", const Color(0xFFFDEBC8)),
          _pipelineTile("12", "Prospect", const Color(0xFFC2D3FF)),
          _pipelineTile("8", "Qualified", const Color(0xFFC3E7C2)),
        ],
      ),
    );
  }

  Widget _pipelineTile(String count, String label, Color dotColor) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
            ),
            Container(width: 2, height: 50, color: dotColor),
          ],
        ),
        const Gap(18),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColors.grayD6),
            ),
            child: Row(
              children: [
                Text(count, style: MyTexts.bold20),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: dotColor.withValues(alpha: 0.4),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(label, style: MyTexts.regular14.copyWith(color: MyColors.gray54)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _followUpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Follow Up", style: MyTexts.medium16),
            const Spacer(),
            SvgPicture.asset(Asset.pin),
          ],
        ),
        const Gap(20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grayEA),
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFF3F8FF),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFFFCF5),
                  border: Border.all(color: MyColors.grayDC),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notes : ",
                      style: MyTexts.medium12.copyWith(color: const Color(0xFF737272)),
                    ),
                    const Gap(8),
                    const Text("Notes will be added here", style: TextStyle(color: Colors.black54)),
                    const Gap(16),
                  ],
                ),
              ),
              const Gap(12),
              CommonTextField(
                bgColor: const Color(0xFFE8EBFE),
                controller: controller.quoteController,
                maxLine: 2,
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _followIcon(Asset.calendar, "Date & time"),
                  _followIcon(Asset.userPlus, "Collaboration"),
                  _followIcon(Asset.paperclip, "Attach"),
                  _followIcon(Asset.moreV, "More"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _followIcon(String icon, String text) {
    return Column(
      children: [
        SvgPicture.asset(icon, height: 24, width: 24),
        const Gap(8),
        Text(text, style: MyTexts.medium12),
      ],
    );
  }

  Widget _requirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Requirement", style: MyTexts.medium16),
            const Spacer(),
            GestureDetector(
              onTap: () => _openTeamBottomSheet(),
              child: SvgPicture.asset(Asset.edit),
            ),
          ],
        ),
        const Gap(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grayD6),
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFF3F8FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reqText("Product"),
              _reqText("Qty"),
              _reqText("Location"),
              _reqText("Delivery Date"),
              _reqText("Quantity"),
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EAFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red),
                    Gap(16),
                    Text("Adobe.pdf"),
                    Spacer(),
                    Icon(Icons.visibility, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reqText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: MyTexts.medium15),
    );
  }

  Widget _conversationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Conversation", style: MyTexts.medium16),
        const Gap(14),

        Row(
          children: [
            Expanded(child: _conversationCard("Last")),
            const Gap(14),
            Expanded(child: _conversationCard("Next")),
          ],
        ),
      ],
    );
  }

  Widget _conversationCard(String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayE6),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF3F8FF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTexts.medium16),
          const Gap(6),
          Text(
            "Quote was shared and negotiations is going on",
            style: MyTexts.regular14.copyWith(color: Colors.black),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Team member & Time",
                style: MyTexts.medium13.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openTeamBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new, size: 20),
                  const SizedBox(width: 8),
                  Text("Team", style: MyTexts.bold20),
                  const Spacer(),
                  GestureDetector(
                    onTap: Get.back,
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: MyColors.grayF7,
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _teamCard(
                        image: "https://picsum.photos/200/300",
                        name: "Name",
                        designation: "Designation",
                        ratio: "Conversation Ration",
                      ),
                      const SizedBox(height: 20),
                      _teamCard(
                        image: "https://picsum.photos/200/400",
                        name: "Name",
                        designation: "Designation",
                        ratio: "Conversation Ration",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _teamCard({
    required String image,
    required String name,
    required String designation,
    required String ratio,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(image, height: 70, width: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name :", style: MyTexts.medium14),
                    const Gap(7),
                    Text("Designation :", style: MyTexts.medium14),
                    const Gap(7),
                    Text("Conversation Ration :", style: MyTexts.medium14),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF142243),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("Assign", style: MyTexts.bold14.copyWith(color: Colors.white)),
                  ),
                  const Gap(8),
                  SvgPicture.asset(Asset.calendar),
                  const Gap(8),
                  SvgPicture.asset(Asset.chat),
                ],
              ),
            ],
          ),

          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("  Priority  ", style: MyTexts.medium14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green.shade700,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("High", style: MyTexts.medium13.copyWith(color: Colors.white)),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const CommonTextField(
            hintText: "Note:Typing....",
            maxLine: 3,
          )
        ],
      ),
    );
  }
}
