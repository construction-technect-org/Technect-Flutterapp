import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/controllers/connection_inbox_controller.dart';

class ConnectionInboxView extends GetView<ConnectionInboxController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: WelcomeName(),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(22.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 8),
                      child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    hintText: 'Search',
                    hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                    filled: true,
                    fillColor: MyColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Connection Inbox",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                ),
              ),
            ),

            SizedBox(height: 2.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: const Border(
                        left: BorderSide(color: MyColors.green, width: 2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row: Avatar + Text
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/41.jpg",
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mike Junior wants to connect with you",
                                      style: MyTexts.medium14.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      "User   •   12 Aug 2025, 08:00pm",
                                      style: MyTexts.medium12.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 1.h),

                          // Buttons Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Connect Button
                              ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // prevent dismiss on tap outside
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
                                              SizedBox(
                                                height: 120,
                                                child: Image.asset(
                                                  Asset.connectToCrm,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(height: 2.h),

                                              Text(
                                                "Connect to CRM!",
                                                style: MyTexts.extraBold20.copyWith(
                                                  color: MyColors.primary,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 1.h),
                                              Text(
                                                "To Proceed with your request, please connect to CRM.",
                                                style: MyTexts.regular16.copyWith(
                                                  color: MyColors.dopelyColors,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 24),
                                              Center(
                                                child: RoundedButton(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  buttonName: '',
                                                  borderRadius: 12,
                                                  width: 40.w,
                                                  height: 45,
                                                  verticalPadding: 0,
                                                  horizontalPadding: 0,
                                                  color: MyColors.lightBlue,
                                                  child: Center(
                                                    child: Text(
                                                      'Proceed',
                                                      style: MyTexts.medium16.copyWith(
                                                        color: MyColors.white,
                                                        fontFamily: MyTexts.Roboto,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.check_circle_outline,
                                  color: MyColors.white,
                                ),
                                label: Text(
                                  "Connect",
                                  style: MyTexts.medium14.copyWith(color: MyColors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primary, // Navy Blue
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              // Disconnect Button
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.cancel_outlined, color: MyColors.white),
                                label: Text(
                                  "Disconnect",
                                  style: MyTexts.medium14.copyWith(color: MyColors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
