import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class ConnectorTeamMemberScreen extends StatelessWidget {
  ConnectorTeamMemberScreen({super.key});

  final eController = Get.put<ConnectorTeamMemberController>(
    ConnectorTeamMemberController(),
  );
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: eController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.moreIBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Members'),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(16),
                              CommonTextField(
                                hintText: "Enter name",
                                headerText: "Name",
                                controller: eController.nameController,
                                autofillHints: const [AutofillHints.name],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  NameInputFormatter(),
                                ],
                                validator: (value) =>
                                    validateName(value, fieldName: "name"),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "Enter number of members",
                                headerText: "Number of Members",
                                controller:
                                    eController.numberOfMembersController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Number of members is required";
                                  }
                                  final number = int.tryParse(value);
                                  if (number == null || number <= 0) {
                                    return "Enter a valid number";
                                  }
                                  return null;
                                },
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "9292929929",
                                headerText: "Phone Number",
                                controller: eController.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: ValidationUtils
                                    .validateBusinessContactNumber,
                              ),
                              Gap(2.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: "Save",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  eController.updateTeamMember();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectorTeamMemberController extends GetxController {
  final nameController = TextEditingController();
  final numberOfMembersController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    final teamMembers =
        homeController.profileData.value.data?.connectorProfile?.teamMembers;
    nameController.text = teamMembers?.name ?? "";
    numberOfMembersController.text =
        teamMembers?.numberOfMembers?.toString() ?? "";
    phoneNumberController.text = teamMembers?.phoneNumber ?? "";
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<void> updateTeamMember() async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> requestBody = {
        'name': nameController.text.trim(),
        'number_of_members': int.parse(numberOfMembersController.text.trim()),
        'phone_number': phoneNumberController.text.trim(),
      };

      await apiManager.postObject(
        url: APIConstants.connectorTeamMember,
        body: requestBody,
      );

      await Get.find<HomeController>().fetchProfileData();

      Get.back();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    numberOfMembersController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
