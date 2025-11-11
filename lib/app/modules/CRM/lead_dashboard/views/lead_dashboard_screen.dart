import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/analysis_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/crm_vrm_toggle_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/dashboard_header_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/filter_tabs_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/lead_conversation_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/leads_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/pipeline_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/task_section_widget.dart';

class LeadDashboardScreen extends GetView<LeadDashController> {
  const LeadDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.categoryBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SafeArea(
                child: Column(
                  children: [
                    DashboardHeaderWidget(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(8),
                            FilterTabsWidget(),
                            Gap(16),
                            CRMVRMToggleWidget(),
                            Gap(24),
                            LeadsSectionWidget(),
                            Gap(24),
                            TaskSectionWidget(),
                            Gap(24),
                            PipelineSectionWidget(),
                            Gap(24),
                            AnalysisSectionWidget(),
                            Gap(24),
                            LeadConversationSectionWidget(),
                            Gap(24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
