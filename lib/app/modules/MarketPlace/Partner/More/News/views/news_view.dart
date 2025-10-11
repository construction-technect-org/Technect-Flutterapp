import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/controllers/news_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class NewsView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(title: const Text('News'), isCenter: false),
        body: Obx(() {
          if (controller.newsModel.value.data?.news?.isEmpty ?? true) {
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Column(
                  children: [
                    const Gap(20),
                    const Icon(
                      Icons.newspaper_outlined,
                      size: 64,
                      color: MyColors.grey,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'No news available',
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.fontBlack,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Check back later for updates',
                      style: MyTexts.regular14.copyWith(color: MyColors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: MyColors.primary,
            onRefresh: controller.refreshNews,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.newsModel.value.data?.news?.length ?? 0,
              itemBuilder: (context, index) {
                final news = controller.newsModel.value.data!.news![index];
                return _buildNewsCard(news);
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNewsCard(News news) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    news.title ?? '',
                    style: MyTexts.bold16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
                Text(
                  _formatDate(news.createdAt),
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.grey,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              ],
            ),
            const Gap(8),
            ReadMoreText(
              news.description ?? '',
              trimMode: TrimMode.Line,
              style: MyTexts.regular14.copyWith(
                color: MyColors.fontBlack,
                height: 1.4,
                fontFamily: MyTexts.Roboto,
              ),
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: MyTexts.Roboto,
                color: MyColors.primary,
              ),
              lessStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: MyTexts.Roboto,
                color: MyColors.primary,
              ),
            ),
            const Gap(12),
            Row(
              children: [
                const Icon(Icons.visibility, size: 16, color: MyColors.grey),
                const SizedBox(width: 4),
                Text(
                  'Published',
                  style: MyTexts.regular12.copyWith(
                    color: MyColors.grey,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
