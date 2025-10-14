import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

class SuccessScreen extends StatefulWidget {
  String? title;
  String? header;
  String? image;
  Function()? onTap;

  SuccessScreen({super.key, this.title, this.header, this.onTap,this.image});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.image ?? Asset.successImage),
            const Gap(40),
            Text(
              widget.title ??  "Success!",
              style: MyTexts.bold20.copyWith(color: MyColors.primary,fontFamily: MyTexts.SpaceGrotesk),
            ),
            const Gap(5),
            Text(
              widget.header ??  "Thanks for Connecting !",
              style: MyTexts.medium16.copyWith(color: MyColors.grey),
            ),
            const Gap(40),
            RoundedButton(
              buttonName: "PROCEED",
              onTap: widget.onTap,
              height: 67,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
