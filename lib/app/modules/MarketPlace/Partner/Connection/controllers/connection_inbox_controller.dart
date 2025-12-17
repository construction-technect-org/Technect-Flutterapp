import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/model/connectionModel.dart';

class ConnectionInboxController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoader = false.obs;
  RxList<Connection> connections = <Connection>[].obs;
  RxList<Connection> filteredConnections = <Connection>[].obs;
  RxString searchQuery = ''.obs;
  Rx<Statistics> statistics = Statistics().obs;
  RxInt selectedTabIndex = 0.obs;
  final ApiManager apiManager = ApiManager();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        if(PermissionLabelUtils.canShow(PermissionKeys.connectionManager)){
          await fetchConnections(isLoad: false);
        }
        isLoading.value = false;
      });
    });
  }

  Future<void> fetchConnections({String? status, bool? isLoad}) async {
    try {
      isLoader.value = isLoad ?? true;
      final Map<String, dynamic> params = {};
      if (status != null) {
        params['status'] = status;
      }
      final response = await apiManager.get(
        url: myPref.role.val == "connector"
            ? APIConstants.connectionConnectorInbox
            : APIConstants.connectionInbox,
        params: params.isNotEmpty ? params : null,
      );
      final connectionModel = ConnectionModel.fromJson(response);
      connections.assignAll(connectionModel.data ?? []);
      _filterByItemType();
      statistics.value = connectionModel.statistics ?? Statistics();
      isLoader.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoader.value = false;
    }
  }

  void searchConnections(String value) {
    searchQuery.value = value;

    List<Connection> typeFiltered = connections;
    if (selectedTabIndex.value == 1) {
      typeFiltered = connections.where((connection) {
        return (connection.itemType?.toLowerCase() ?? 'unknown') == 'product';
      }).toList();
    } else if (selectedTabIndex.value == 2) {
      typeFiltered = connections.where((connection) {
        return (connection.itemType?.toLowerCase() ?? 'unknown') == 'service';
      }).toList();
    }

    if (value.isEmpty) {
      filteredConnections.clear();
      filteredConnections.addAll(typeFiltered);
    } else {
      filteredConnections.clear();
      filteredConnections.value = typeFiltered.where((connection) {
        return (connection.connectorName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (connection.productName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (connection.serviceName ?? '').toLowerCase().contains(
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

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
    _filterByItemType();
  }

  void _filterByItemType() {
    if (selectedTabIndex.value == 0) {
      filteredConnections.clear();
      filteredConnections.addAll(connections);
    } else {
      final filterType = selectedTabIndex.value == 1 ? 'product' : 'service';
      filteredConnections.clear();
      filteredConnections.value = connections.where((connection) {
        return (connection.itemType?.toLowerCase() ?? 'unknown') == filterType;
      }).toList();
    }
    if (searchQuery.value.isNotEmpty) {
      searchConnections(searchQuery.value);
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    _filterByItemType();
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
      // No need to show error
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
