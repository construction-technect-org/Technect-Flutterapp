import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/stepper_edit_profile_widget.dart';
import 'package:construction_technect/app/modules/UpdateYourCertifications/controllers/update_your_certifications_controller.dart';
import 'package:construction_technect/app/modules/profile/components/certifications_component.dart';

class UpdateYourCertificationsView
    extends GetView<UpdateYourCertificationsController> {
  const UpdateYourCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [StepperEditProfileWidget(currentStep: 1)],
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "EDIT PROFILE",
                      style: MyTexts.bold18.copyWith(
                        color: MyColors.primary,
                        fontSize: 24,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Update your Business Details",
                      style: MyTexts.bold18.copyWith(
                        color: MyColors.greyDetails,
                        fontSize: 14,
                        fontFamily: MyTexts.Roboto,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),
            const CertificationsComponent(),


             SizedBox(height: 3.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedButton(
                        buttonName: 'UPDATE',
                        onTap: () {
                         // controller.completeSignUp();
                        },
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
