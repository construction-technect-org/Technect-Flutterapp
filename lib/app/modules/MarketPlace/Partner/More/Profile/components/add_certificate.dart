import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';

class AddCertificate extends StatefulWidget {
  const AddCertificate({super.key});

  @override
  State<AddCertificate> createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  final TextEditingController titleController = TextEditingController();
  String? filePath;

  ProfileController get controller => Get.find<ProfileController>();

  Future<void> _pickFile() async {
    final path = await controller.pickFile();
    if (path != null) {
      setState(() {
        filePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: CommonAppBar(
          isCenter: false,
          title: const Text("ADD CERTIFICATE"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                controller: titleController,
                headerText: "Certificate name",
                hintText: "Enter your certificate name",
                textInputAction: TextInputAction.done,
              ),
              const Gap(20),
              Text(
                "ADD FILE",
                style: MyTexts.bold16.copyWith(
                  color: Colors.black,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: filePath==null? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColors.grey),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: const Icon(Icons.add, size: 30, color: MyColors.grey),
                      ),
                      const Gap(10),
                      Text(
                        filePath ?? "Select File you want to upload",
                        style: MyTexts.medium14.copyWith(color: MyColors.grey),
                      ),
                      const Gap(10),
                      Text(
                        "Upload Certification",
                        style: MyTexts.bold16.copyWith(color: MyColors.black),
                      ),
                    ],
                  ):Column(
                    children: [
                      const Gap(14),

                      Image.asset(Asset.pdfImage, height: 50, width: 32),
                      const Gap(14),
                      Text(
                        "File uploaded: ${basename("$filePath")}",
                      ),

                      const Gap(14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: "Add",
            onTap: () {
              if (titleController.text.isNotEmpty && filePath != null) {
                final cert = CertificateModel(
                  title: titleController.text,
                  filePath: filePath,
                  name: basename(filePath??"")
                );
                Get.back(result: cert);
              } else {
                SnackBars.errorSnackBar(content: "Please fill all fields");
              }
            },
          ),
        ),
      ),
    );
  }
}
