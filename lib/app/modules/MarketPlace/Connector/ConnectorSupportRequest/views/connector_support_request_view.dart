import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class ConnectorSupportRequestView extends StatelessWidget {
  const ConnectorSupportRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        isCenter: false,
        // ignore: prefer_const_constructors
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Text("Support Request")],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
  itemCount: 20,
  itemBuilder: (context, index) {
    final bool isActive = index == 0;
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(Asset.profileEmoji),
          ),
          title:  Text(
            "Mohan Das",
            style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
          ),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Default Request", style: MyTexts.medium16.copyWith(
                color: MyColors.veryDarkGray,
                fontFamily: MyTexts.Roboto,
              ),),
               SizedBox(height: 0.3.h),
               Text(
                "12 Mar 2025, 03:22 pm",
               style: MyTexts.medium12.copyWith(
                color: MyColors.dustyGray,
                fontFamily: MyTexts.Roboto,
              ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.circle,
            color: isActive ? MyColors.green : MyColors.primary,
            size: 20,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey, // line color
          ),
        ),
      ],
    );
  },
)

   
    );
  }
}
