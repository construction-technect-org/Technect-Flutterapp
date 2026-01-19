import 'package:construction_technect/app/core/utils/common_appbar.dart';

import 'package:construction_technect/app/core/utils/imports.dart';

class MerchantProjectViewDetails extends StatelessWidget {
  const MerchantProjectViewDetails({super.key});

  Widget timeline() {
    return Column(children: [timelineDot(), timelineLine(180), timelineDot()]);
  }

  Widget timelineDot() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFACC80).withAlpha(50),
      ),
      child: const Center(
        child: CircleAvatar(radius: 4, backgroundColor: Color(0xFFFFED29)),
      ),
    );
  }

  Widget timelineLine(double height) {
    return Container(width: 2, height: height, color: const Color(0xFFFFF4B2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text("Project Details", style: MyTexts.medium20),
        action: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, size: 24, color: Colors.black),
          ),
        ],
        isCenter: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image.asset(Asset.building, fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, top: 10),
                      height: 24,
                      width: 124,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [
                            const Color(0xFFFFF9BD).withValues(alpha: 0),
                            const Color(0xFFFFF9BD),
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("₹ 1600", style: MyTexts.medium15),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 22.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 70.w,
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.w),
                          boxShadow: const [
                            BoxShadow(blurRadius: 10, color: Colors.black26),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Luna's Tranquil Escape",
                                  style: MyTexts.medium16,
                                ),
                                Container(
                                  width: 58,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF9BD),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 10.sp,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        " 18 KM",
                                        style: MyTexts.regular12.copyWith(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: const Color(0xFF545454),
                                  size: 14.sp,
                                ),
                                const Gap(2),
                                Text(
                                  "Sunny Meadows, Bangalore ",
                                  style: MyTexts.regular12.copyWith(
                                    color: const Color(0xFF545454),
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const Gap(14),
                            const Divider(thickness: 1, color: MyColors.grayEA),
                            const Gap(5),
                            Text(
                              "Estimated Value",
                              style: MyTexts.regular14.copyWith(
                                color: const Color(0xFF1B2F62),
                              ),
                            ),
                            const Gap(13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("₹2,50,000", style: MyTexts.regular14),
                                RoundedButton(
                                  buttonName: "Open",
                                  width: 61,
                                  height: 22,
                                  fontSize: 9,
                                  style: MyTexts.regular12.copyWith(
                                    fontSize: 9,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: const Color(0xFFE7E7E7),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Builder Information", style: MyTexts.medium16),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Gap(26),
                    getRowTextWidget("Builder", "Luna's Construction"),
                    const Gap(26),
                    getRowTextWidget("Contact Person", "Arun Kumar"),
                    const Gap(26),
                    getRowTextWidget("Phone Number", "+919876543210"),
                    const Gap(26),
                    getRowTextWidget("Email ID", "luna.construction@gmail.com"),
                  ],
                ),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Project Status", style: MyTexts.medium16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: MyTexts.regular12.copyWith(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(31),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeline(),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      children: const [
                        ActivePhaseCard(),
                        SizedBox(height: 24),
                        CompletedPhaseCard(),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("About Project", style: MyTexts.medium16),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  border: Border.all(color: const Color(0xFFE3E3E3)),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        Asset.building,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    const Gap(18),
                    Expanded(
                      child: Text(
                        "A thoughtfully planned residential development featuring bright interiors, reliable construction, and community-focused amenities for families and professionals",
                        style: MyTexts.regular14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Explore More!", style: MyTexts.medium13),
                const Gap(4),
                GestureDetector(
                  child: Text(
                    "View Categories >",
                    style: MyTexts.medium13.copyWith(
                      color: const Color(0xFF2E2E2E),
                    ),
                  ),
                ),
              ],
            ),
            RoundedButton(
              buttonName: "Connect",
              height: 4.h,
              width: 15.w,
              fontSize: 13.sp,
              borderRadius: 1.5.w,
              style: MyTexts.medium13.copyWith(color: Colors.white),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget getRowTextWidget(String data, String data1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(data, style: MyTexts.medium16),
        Text(data1, style: MyTexts.regular14),
      ],
    );
  }
}

class CompletedPhaseCard extends StatelessWidget {
  const CompletedPhaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Foundation Pouring",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Dec 10 · completed",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.image_outlined, size: 18, color: Colors.grey),
          const SizedBox(width: 4),
          const Text("3"),
        ],
      ),
    );
  }
}

class ActivePhaseCard extends StatelessWidget {
  const ActivePhaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PHASE TAG
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4B2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Phase 3",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 8),

          /// TITLE
          const Text(
            "Structural Frame Work",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          /// DESCRIPTION
          const Text(
            "Steel beam installation for the 4th floor is "
            "progress ahead of schedule inspection scheduled "
            "for tomorrow morning",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 12),

          /// IMAGES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              phaseImage(Asset.building),
              phaseImage(Asset.building),
              phaseImage(Asset.building, showPlay: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget phaseImage(String asset, {bool showPlay = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(asset, width: 80, height: 65, fit: BoxFit.cover),
          ),
          if (showPlay)
            const Icon(Icons.play_circle_fill, color: Colors.white, size: 24),
        ],
      ),
    );
  }
}
