import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/add_new_lead_button.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/segment_filters_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/topbar_header.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/white_card_widget.dart';

class MarketingScreen extends GetView<MarketingController> {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(Asset.categoryBg, fit: BoxFit.cover),
              ),

              Column(
                children: [
                  const TopBarHeader(),
                  const SegmentFiltersWidget(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              WhiteCardWidget(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AddNewLeadButton(
                                      onTap: () => controller.onAdd(context),
                                    ),
                                    const SizedBox(height: 18),
                                    const TodaysLeadsCard(),
                                    const SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Lead Details',
                                        style: MyTexts.medium20,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    Obx(
                                      () => Column(
                                        children: controller.leads
                                            .map(
                                              (l) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                    ),
                                                child: LeadItemCard(
                                                  lead: l,
                                                  controller: controller,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),

                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
