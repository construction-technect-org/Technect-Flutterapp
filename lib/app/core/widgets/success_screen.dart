import 'package:construction_technect/app/core/utils/imports.dart';

class SuccessScreen extends StatefulWidget {
  final String? title;
  final String? header;
  final String? image;
  final Function()? onTap;

  const SuccessScreen({super.key, this.title, this.header, this.onTap, this.image});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (widget.onTap != null) widget.onTap!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.loginBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MyColors.grayEA),
            ),
            child: Text(
              widget.header ?? "",
              style: MyTexts.bold18.copyWith(color: const Color(0xFF058200)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
