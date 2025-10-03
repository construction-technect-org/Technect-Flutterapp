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

  const ConnectorCategoryCard({Key? key, required this.category, this.isSelected = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, // <-- important to allow overflow
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(category.imagePath),
              ),
            ),
            if (isSelected)
              Positioned(
                top: -5, // move it slightly above the container
                right: -5, // move it slightly outside the border
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 1), // optional outline
                  ),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(height: 0.6.h),
        Flexible(
          child: Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: MyTexts.medium12.copyWith(
              color: isSelected ? MyColors.primary : MyColors.fontBlack,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }
}
