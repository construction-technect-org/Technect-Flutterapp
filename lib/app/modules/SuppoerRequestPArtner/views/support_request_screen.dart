import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/ticket_list_view.dart';
import 'package:construction_technect/app/modules/SuppoerRequestPArtner/controller/support_request_controller.dart';

class SupportRequestScreen extends GetView<SupportRequestController> {
  const SupportRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            isCenter: false,
            title: const Text("Support Request"),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if(controller.myTickets.isEmpty){
             return  Center(
               child: Text(
                  "No tickets found !!",
                  style: MyTexts.regular16.copyWith(color: Colors.black),
                ),
             );
            }
            else {
              return SingleChildScrollView(
                child: TicketListView(list: controller.myTickets),
              );
            }
          }),
        ),
      ),
    );
  }
}
