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
                  title: const Text('News'),
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
                    child: Column(
                      children: [
                        Obx(() {
                          if (controller.newsModel.value.data?.news?.isEmpty ??
                              true) {
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
                                      style: MyTexts.regular14.copyWith(
                                        color: MyColors.grey,
                                      ),
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
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16),
                              itemCount:
                                  controller
                                      .newsModel
                                      .value
                                      .data
                                      ?.news
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final news = controller
                                    .newsModel
                                    .value
                                    .data!
                                    .news![index];
                                return _buildNewsCard(news);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(News news) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: MyColors.grayF7,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MyColors.grayEA.withValues(alpha: 0.32),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Gap(16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        news.title ?? '',
                        style: MyTexts.medium16.copyWith(color: MyColors.black),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                ReadMoreText(
                  news.description ?? '',
                  trimMode: TrimMode.Line,
                  style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                  trimLines: 3,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: MyTexts.SpaceGrotesk,
                    color: MyColors.primary,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: MyTexts.SpaceGrotesk,
                    color: MyColors.primary,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.visibility,
                      size: 12,
                      color: MyColors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Published',
                      style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatDate(news.createdAt),
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.gray54,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    final String day = date.day.toString();
    String suffix;
    if (day.endsWith('1') && day != '11') {
      suffix = 'st';
    } else if (day.endsWith('2') && day != '12') {
      suffix = 'nd';
    } else if (day.endsWith('3') && day != '13') {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    final String formattedDate = DateFormat("MMM yyyy, hh:mm a").format(date);
    return "${date.day}$suffix $formattedDate";
  }
}
