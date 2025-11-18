import 'package:construction_technect/app/modules/CRM/marketing/view/widget/status_view_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';
import 'package:flutter/widgets.dart';

class FollowupScreen extends StatelessWidget {
  const FollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TodaysLeadsCard(),
        SizedBox(height: 20),
        StatusViewWidget(),
        SizedBox(height: 20),
      ],
    );
  }
}
