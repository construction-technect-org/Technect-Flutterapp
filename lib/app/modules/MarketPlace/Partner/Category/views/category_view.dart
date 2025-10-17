import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Construction Materials",
      "Interior Materials",
      "Brands",
      "New Launches",
      "Best Sellers",
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            margin: const EdgeInsets.only(top: 25),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.categoryBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Text(
                  "Category",
                  style: MyTexts.medium20.copyWith(
                    color: MyColors.gray2E,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Asset.cBg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    categories[index],
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: MyColors.gra54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  "Need Help in Buying ?",
                  style: MyTexts.bold18.copyWith(
                    color: MyColors.gray2E,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
