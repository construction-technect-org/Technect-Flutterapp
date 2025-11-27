import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

void hideKeyboard() {
  final context = Get.context;
  if (context != null) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      currentFocus.unfocus();
    }
  }
}

Future<void> makePhoneCall({required String phoneNumber}) async {
  final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not call $phoneNumber';
  }
}

Future<void> openUrl({required String url}) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

CachedNetworkImage getImageView({
  required String finalUrl,
  double height = 40,
  double width = 40,
  Decoration? shape,
  BoxFit? fit,
  Color? color,
}) {
  return CachedNetworkImage(
    imageUrl: finalUrl,
    fit: fit,
    height: height,
    width: width,
    placeholder: (context, url) => Container(
      margin: const EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: const BoxDecoration(color: MyColors.grayF7),
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: MyColors.primary),
      ),
    ),
    errorWidget: (context, url, error) => SizedBox(
      height: height,
      width: width,
      child: SizedBox(
        height: height,
        width: width,
        // decoration: const BoxDecoration(color: MyColors.grayD4, shape: BoxShape.circle),
        child: Image.asset(Asset.appLogo, height: height, width: width, fit: BoxFit.contain),
      ),
    ),
  );
}
