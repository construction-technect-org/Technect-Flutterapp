// Category Model
import 'package:construction_technect/app/core/utils/imports.dart';

class CategoryItem {
  final String name;
  final String imagePath;

  CategoryItem(this.name, this.imagePath);
}

class ConnectorCategoryCard extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;

  const ConnectorCategoryCard({
    Key? key,
    required this.category,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(category.imagePath, fit: BoxFit.cover),
              ),
            ),
            if (isSelected)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 100,
          child: Text(
            category.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: MyTexts.medium12.copyWith(
              color: isSelected ? MyColors.primary : MyColors.fontBlack,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ),
      ],
    );
  }
}
