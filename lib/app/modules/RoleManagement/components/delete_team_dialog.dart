import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';

class DeleteTeamDialog {
  static void showDeleteTeamDialog(
    BuildContext context,
    TeamListData teamMember,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 64,
                  color: Colors.orange,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Delete Team Member",
                  style: MyTexts.extraBold20.copyWith(
                    color: MyColors.fontBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Are you sure you want to delete ${teamMember.firstName ?? ''} ${teamMember.lastName ?? ''}?",
                  style: MyTexts.regular16.copyWith(
                    color: MyColors.darkGray,
                    fontFamily: MyTexts.Roboto,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  "This action cannot be undone.",
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.grey,
                    fontFamily: MyTexts.Roboto,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.lightGray,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        buttonName: 'Delete',
                        borderRadius: 12,
                        verticalPadding: 0,
                        height: 45,
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
