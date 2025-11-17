import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/widgets/loader_wrapper.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/header_icon_widget.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/add_new_lead_button.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/lead_item_Card.dart';
import 'package:construction_technect/app/modules/CRM/marketing/view/widget/todays_leads_card.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.categoryBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopBar(controller: controller),
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _SegmentFilters(controller: controller),
                            const SizedBox(height: 20),
                            _WhiteCard(
                              child: Column(
                                children: [
                                  AddNewLeadButton(
                                    onTap: () => _onAdd(context),
                                  ),
                                  const SizedBox(height: 18),
                                  const TodaysLeadsCard(),
                                  const SizedBox(height: 20),
                                  const Row(
                                    children: [
                                      Text(
                                        'Lead Details',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAdd(BuildContext ctx) {
    // Example: open dialog to add a LeadModel
    final c = controller;
    final now = DateTime.now();
    c.addLead(
      LeadModel(
        id: '#CTO${1000 + c.leads.length + 1}',
        name: 'New LeadModel ${c.leads.length + 1}',
        connector: 'Connector X',
        product: 'Concrete',
        distanceKm: 1.2,
        dateTime: now,
        avatarUrl: 'https://i.pravatar.cc/150?img=${20 + c.leads.length}',
      ),
    );
  }
}

// --------------------------
// Top bar (Marketing pill + icons)
// --------------------------
class _TopBar extends StatelessWidget {
  final MarketingController controller;
  const _TopBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios),
          ),

          const SizedBox(width: 6),

          // FIX: Prevent overflow by allowing pill to shrink
          Expanded(
            child: Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: _Pill(text: controller.category.value),
              ),
            ),
          ),

          // FIX: Icons wrapped in Row(mainAxisSize: min)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => HeaderIconWidget(
                  icon: Asset.chat,
                  count: controller.chatNotificationCount.value,
                  onTap: () => Get.toNamed(Routes.All_CHAT_LIST),
                ),
              ),
              const Gap(12),
              Obx(
                () => HeaderIconWidget(
                  icon: Asset.notification,
                  isAlert: true,
                  count: controller.alertNotificationCount.value,
                  onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                ),
              ),
              const Gap(12),
              Obx(
                () => HeaderIconWidget(
                  icon: Asset.notification,
                  count: controller.bellNotificationCount.value,
                  onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF17345A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  final IconData icon;
  final RxInt count;
  const _IconWithBadge({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(icon, color: Colors.black87),
          ),
          if (count.value > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${count.value}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --------------------------
// Segment filters (LeadModel, Follow Up...)
// --------------------------
class _SegmentFilters extends StatelessWidget {
  final MarketingController controller;
  const _SegmentFilters({required this.controller});

  @override
  Widget build(BuildContext context) {
    final items = ['Lead', 'Follow Up', 'Prospect', 'Qualified'];
    return Obx(
      () => Row(
        children: items
            .map(
              (it) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => controller.setFilter(it),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: controller.activeFilter.value == it
                          ? const Color(0xFF17345A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: controller.activeFilter.value == it
                          ? [
                              const BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      it,
                      style: TextStyle(
                        color: controller.activeFilter.value == it
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// --------------------------
// White card container wrapper used in UI
// --------------------------
class _WhiteCard extends StatelessWidget {
  final Widget child;
  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

// --------------------------
// Add New LeadModel Button
// --------------------------
