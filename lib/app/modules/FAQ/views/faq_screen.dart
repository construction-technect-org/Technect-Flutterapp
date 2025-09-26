import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FAQ/controller/faq_controller.dart';
import 'package:gap/gap.dart';

class FaqScreen extends GetView<FAQController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(title: const Text("FAQs"), isCenter: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Frequently Asked Questions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.faqList.length,
                      itemBuilder: (context, index) {
                        final faq = controller.faqList[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.grayD4),
                          ),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            onTap: () {
                              // Toggle open/close
                              if (controller.selectedIndex.contains(index)) {
                                controller.selectedIndex.remove(index);
                              } else {
                                controller.selectedIndex.add(index);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          faq.question??"",
                                          style: MyTexts.medium16.copyWith(
                                            color: Colors.black,
                                            fontFamily: MyTexts.Roboto,
                                          ),
                                        ),
                                      ),
                                      Obx(() {
                                        return Icon(
                                          controller.selectedIndex.contains(index)
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                    .keyboard_arrow_down_outlined,
                                        );
                                      }),
                                    ],
                                  ),
                                  Obx(() {
                                    return controller.selectedIndex.contains(
                                          index,
                                        )
                                        ? Column(
                                            children: [
                                              const Gap(10),

                                              Text(
                                                faq.answer??"",
                                                style: MyTexts.regular16.copyWith(
                                                  color: MyColors.dopelyColors,
                                                  fontFamily: MyTexts.Roboto,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
