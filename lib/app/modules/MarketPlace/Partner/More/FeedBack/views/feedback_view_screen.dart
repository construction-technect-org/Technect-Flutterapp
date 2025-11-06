import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FeedBack/controller/feedback_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class FeedbackViewScreen extends GetView<FeedBackController> {
  const FeedbackViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      controller.suggestionController.text = "";
                      controller.rating.value = 0;
                    },
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      controller.addFeedBack();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              const CommonBgImage(),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Feedback'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Obx(() {
                                return Text(
                                  double.parse(
                                    controller.rating.value.toString(),
                                  ).toString(),
                                  style: MyTexts.bold20.copyWith(
                                    color: MyColors.gray2E,
                                    fontSize: 24.sp,
                                  ),
                                );
                              }),
                            ),
                            // const Gap(),
                            Obx(
                              () => Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.star,
                                        color: index < controller.rating.value
                                            ? Colors.orangeAccent
                                            : Colors.grey,
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        controller.rating.value = index + 1;
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ),
                            const Gap(24),
                            CommonTextField(
                              controller: controller.suggestionController,
                              hintText: "Write your feedback/suggestions",
                              headerText: "Feedback/Suggestions",
                              maxLine: 10,
                            ),
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
      ),
    );
  }
}
