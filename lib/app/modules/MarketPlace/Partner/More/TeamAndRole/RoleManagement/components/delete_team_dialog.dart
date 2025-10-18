import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 1.h),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF9D0CB)),
                      color: const Color(0xFFFCECE9),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                  child: Center(
                    child: Text(
                      "Delete Team Member",
                      style: MyTexts.medium15.copyWith(
                        color: MyColors.gray2E,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Are you sure you want to delete ${teamMember.firstName ?? ''} ${teamMember.lastName ?? ''}?",
                  style: MyTexts.medium14.copyWith(
                    color: MyColors.gray54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Get.back();
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
                          Get.back();
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

class DeleteRoleDialog {
  static void showDeleteRoleDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.orange),
                SizedBox(height: 2.h),
                Text(
                  "Delete Team Member",
                  style: MyTexts.extraBold20.copyWith(color: MyColors.fontBlack),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Are you sure you want to delete role?",
                  style: MyTexts.regular16.copyWith(
                    color: MyColors.darkGray,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  "This action cannot be undone.",
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.grey,
                    fontFamily: MyTexts.SpaceGrotesk,
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
