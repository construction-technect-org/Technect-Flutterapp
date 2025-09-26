import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/FeedBack/controller/feedback_controller.dart';
import 'package:gap/gap.dart';

class FeedbackViewScreen extends GetView<FeedBackController> {
  const FeedbackViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(title: const Text("Feedback"), isCenter: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Give Rating",
                  style: MyTexts.regular16.copyWith(
                    color: MyColors.lightBlue,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                const Gap(8),

                Center(
                  child: Obx(() {
                    return Text(
                      double.parse(controller.rating.value.toString()).toString(),
                      style: MyTexts.bold20.copyWith(
                        color: MyColors.primary,
                        fontFamily: MyTexts.Roboto,
                        fontSize: 24.sp
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
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
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
                            style: TextStyle(color: Colors.white),
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
                            // SnackBars.successSnackBar(content: "Feedback sent successfully");
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(color: MyColors.white),
                          ),
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
    );
  }
}
