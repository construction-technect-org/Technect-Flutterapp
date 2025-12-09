import 'package:construction_technect/app/core/utils/imports.dart';

class HeaderIconWidget extends StatelessWidget {
  const HeaderIconWidget({
    super.key,
    required this.icon,
    required this.count,
    required this.onTap,
    this.isAlert = false,
  });

  final String icon;
  final int count;
  final VoidCallback onTap;
  final bool isAlert;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.custom('EAEAEA')),
              shape: BoxShape.circle,
            ),
            child: isAlert
                ? const Icon(
                    Icons.error_outline,
                    size: 24,
                    color: MyColors.fontBlack,
                  )
                : SvgPicture.asset(icon, width: 24, height: 24),
          ),
          if (count > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    count > 9 ? '9+' : count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
