import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';
import 'package:flutter/widgets.dart';

class QualifiedScreen extends StatelessWidget {
  const QualifiedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(children: [TodaysLeadsCard(), SizedBox(height: 20)]);
  }
}
