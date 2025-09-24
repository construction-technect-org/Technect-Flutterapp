import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorRequestDemo/controllers/connector_request_demo_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ConnectorRequestDemoView extends StatelessWidget {
  final ConnectorRequestDemoController controller = Get.put(
    ConnectorRequestDemoController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        isCenter: false,
        // ignore: prefer_const_constructors
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Text("Request Demo")],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: CommonTextField(
              onChange: (value) {},
              borderRadius: 22,
              hintText: 'Search',
              suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
              prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Request Demo',
              style: MyTexts.medium18.copyWith(
                color: MyColors.lightBlue,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    return controller.showVideo.value
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: YoutubePlayer(
                              controller: controller.youtubeController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: MyColors.primary,
                            ),
                          )
                        : GestureDetector(
                            onTap: controller.playVideo,
                            child: Container(
                              height: 22.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                  }),
                ),

                SizedBox(height: 3.h),
                Row(
                  children: [
                    Text(
                      'Request Demo for',
                      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                    ),
                    Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                  ],
                ),
                SizedBox(height: 1.h),
                CommonDropdown<String>(
                  borderColor: MyColors.primary,
                  hintText: "",
                  items: controller.mainCategories,
                  selectedValue: controller.selectedMainCategory,
                  // pass Rx directly
                  itemLabel: (item) => item,
                  onChanged: controller.isEdit
                      ? null
                      : (value) {
                          controller.onMainCategorySelected(value);
                        },
                  enabled: !controller.isEdit,
                ),
                SizedBox(height: 1.h),

                Row(
                  children: [
                    Text(
                      'Phone Number',
                      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                    ),
                    Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                  ],
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 53,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(Icons.phone, color: MyColors.primary),
                      ),
                      Container(width: 1, height: 3.h, color: MyColors.darkGray),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            controller: controller.PhoneNumberController,
                            keyboardType: TextInputType.phone,
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.primary,
                              fontFamily: MyTexts.Roboto,
                            ),
                            decoration: const InputDecoration(
                              hintText: '+ 91 9087654321',
                              hintStyle: TextStyle(color: MyColors.grayD4),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      'Email',
                      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                    ),
                    Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                  ],
                ),
                SizedBox(height: 1.h),
                CustomTextField(
                  controller: controller.emilaController,
                  onChanged: (p0) {},
                  borderColor: MyColors.primary,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                        ), // 👈 Big left, small right
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 20,
                        ), // 👈 Big left, small right
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {},
                          child: Text("SUBMIT", style: TextStyle(color: MyColors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
