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
          getImageView(finalUrl: "finalUrl", height: 114, width: 78),
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
            SvgPicture.asset(Asset.edit),
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
}
