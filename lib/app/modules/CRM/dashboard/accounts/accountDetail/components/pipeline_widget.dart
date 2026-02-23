import 'package:construction_technect/app/core/utils/imports.dart';

enum MainStage { lead, followUp, prospect, qualified }

class PipelineStage {
  final String title;
  final Color color;
  final List<String> subStages;

  PipelineStage({required this.title, required this.color, required this.subStages});
}

final pipeline = [
  PipelineStage(title: "Lead", color: Colors.red.shade600, subStages: ["New"]),
  PipelineStage(
    title: "Follow Up",
    color: Colors.orange.shade600,
    subStages: ["Pending", "Completed", "Missed"],
  ),
  PipelineStage(
    title: "Prospect",
    color: Colors.blue.shade500,
    subStages: ["Fresh", "Reached Out", "Converted", "On Hold"],
  ),
  PipelineStage(
    title: "Qualified",
    color: Colors.green.shade600,
    subStages: ["All", "Qualified", "Lost"],
  ),
];

class PipelineView extends StatelessWidget {
  final int currentStage;
  final int currentSubStage;

  const PipelineView({super.key, required this.currentStage, required this.currentSubStage});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pipeline.length,
      itemBuilder: (context, i) {
        final stage = pipeline[i];
        final active = i <= currentStage;
        return Container(
          margin: const EdgeInsets.only(bottom: 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: stage.color.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        stage.title,
                        style: MyTexts.medium15.copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 30),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(4),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: active ? stage.color : stage.color.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: active ? stage.color : stage.color.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: active ? stage.color : stage.color.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (stage.subStages.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.only(left: 5),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stage.subStages.length,
                        itemBuilder: (context, j) {
                          final highlight =
                              (i < currentStage) ||
                                  (i == currentStage && j == currentSubStage);

                          return Row(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: highlight
                                          ? stage.color
                                          : stage.color.withValues(alpha: 0.5),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Gap(5),
                                  Container(
                                    width: 2,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: highlight
                                              ? stage.color.withValues(alpha: .5)
                                              : stage.color.withValues(alpha: .2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(30),
                              Text(
                                stage.subStages[j],
                                style: TextStyle(
                                  fontFamily: MyTexts.SpaceGrotesk,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: highlight
                                      ? stage.color
                                      : stage.color.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    // if (stage.subStages.isEmpty)
                    //   Container(
                    //     width: 2,
                    //     height: 10,
                    //     margin: const EdgeInsets.only(left: 10),
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         right: BorderSide(
                    //           color: active
                    //               ? stage.color.withValues(alpha: .5)
                    //               : Colors.grey.shade300,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
