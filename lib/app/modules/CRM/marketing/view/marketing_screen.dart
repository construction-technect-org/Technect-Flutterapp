import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/segment_filters_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/topbar_header.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/white_card_widget.dart';

class MarketingScreen extends GetView<MarketingController> {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketingController c = controller;
    return LoaderWrapper(
      isLoading: c.isLoading,
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
                      child: Obx(
                        () => SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child:
                                c.filterScreens[c.activeFilter.value] ??
                                const LeadScreen(),
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
