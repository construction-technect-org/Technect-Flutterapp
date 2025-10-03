import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/model/connectionModel.dart';

class ConnectionInboxController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Connection> connections = <Connection>[].obs;
  RxList<Connection> filteredConnections = <Connection>[].obs;
  RxString searchQuery = ''.obs;
  Rx<Statistics> statistics = Statistics().obs;
  final ApiManager apiManager = ApiManager();

  @override
  void onInit() {
    super.onInit();
    fetchConnections();
  }

  Future<void> fetchConnections({String? status}) async {
    try {
      isLoading.value = true;
      final response = await apiManager.get(
        url: "${APIConstants.connectionInbox}?status=pending",
        params: status != null ? {"status": status} : null,
      );
      final connectionModel = ConnectionModel.fromJson(response);
      connections.assignAll(connectionModel.data ?? []);
      filteredConnections.clear();
      filteredConnections.addAll(connectionModel.data ?? []);
      statistics.value = connectionModel.statistics ?? Statistics();
    } catch (e) {
      // No need to show error
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

  Future<void> acceptConnection(
    int connectionId,
    String responseMessage,
  ) async {
    try {
      isLoading.value = true;
      final response = await apiManager.putObject(
        url: "${APIConstants.acceptReject}/$connectionId/accept",
        body: {"response_message": responseMessage},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection accepted successfully');
        await fetchConnections();
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to accept connection',
        );
      }
    } catch (e) {
      // No need to show errorputObject
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectConnection(
    int connectionId,
    String responseMessage,
  ) async {
    try {
      isLoading.value = true;
      final response = await apiManager.putObject(
        url: "${APIConstants.acceptReject}/$connectionId/reject",
        body: {"response_message": responseMessage},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection rejected successfully');
        await fetchConnections();
      } else {
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to reject connection',
        );
      }
    } catch (e) {
      // No need to show error
    } finally {
      isLoading.value = false;
    }
  }
}
