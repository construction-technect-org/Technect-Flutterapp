import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/model/connectionModel.dart';
import 'package:get/get.dart';

class ConnectorConnectionInboxController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Connection> connections = <Connection>[].obs;
  RxList<Connection> filteredConnections = <Connection>[].obs;
  RxString searchQuery = ''.obs;
  Rx<Statistics> statistics = Statistics().obs;
  final ApiManager apiManager = ApiManager();
  RxString selectedStatus = "accepted".obs;

  @override
  void onInit() {
    super.onInit();
    fetchConnections();
  }

  Future<void> fetchConnections() async {
    try {
      isLoading.value = true;
      final response = await apiManager.get(
        url: APIConstants.connectionConnectorInbox,
        params: selectedStatus.value.isNotEmpty ? {"status": selectedStatus.value} : null,
      );
      final connectionModel = ConnectionModel.fromJson(response);
      connections.assignAll(connectionModel.data ?? []);
      filteredConnections.clear();
      filteredConnections.addAll(connectionModel.data ?? []);
      statistics.value = connectionModel.statistics ?? Statistics();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void searchConnections(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      filteredConnections.clear();
      filteredConnections.addAll(connections);
    } else {
      filteredConnections.clear();
      filteredConnections.value = connections.where((connection) {
        return (connection.connectorName ?? '').toLowerCase().contains(
          value.toLowerCase(),
        ) ||
            (connection.productName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (connection.requestMessage ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (connection.merchantName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            );
      }).toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredConnections.clear();
    filteredConnections.addAll(connections);
  }

  Future<void> cancelConnection(
      int connectionId,
      ) async {
    try {
      isLoading.value = true;
      final response = await apiManager.put(
        url: "${APIConstants.cancelConnection}/$connectionId/cancel",
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection cancel successfully');
        await fetchConnections();
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to cancel connection',
        );
      }
    } catch (e) {
      // No need to show errorputObject
    } finally {
      isLoading.value = false;
    }
  }
}
