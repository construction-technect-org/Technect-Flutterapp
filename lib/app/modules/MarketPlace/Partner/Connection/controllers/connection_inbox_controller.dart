import "dart:developer";


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/model/connectionModel.dart';

class ConnectionInboxController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoader = false.obs;
  RxList<Connection> incomingConnections = <Connection>[].obs;
  RxList<Connection> outgoingConnections = <Connection>[].obs;
  RxList<Connection> filteredConnections = <Connection>[].obs;
  RxString searchQuery = ''.obs;
  // Rx<Statistics> statistics = Statistics().obs;
  RxInt selectedTabIndex = 0.obs;
  final ApiManager apiManager = ApiManager();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        if (PermissionLabelUtils.canShow(PermissionKeys.connectionManager)) {
          await fetchIncomingConnections(isLoad: false);
          await fetchOutgoingConnections(isLoad: false);
        }
        isLoading.value = false;
      });
    });
  }

  Future<void> fetchIncomingConnections({String? status, bool? isLoad}) async {
    try {
      isLoader.value = isLoad ?? true;
      final Map<String, dynamic> params = {};
      if (status != null) {
        params['status'] = status;
      }
      final response = await apiManager.get(
        url: APIConstants.incomingConnectionInbox,
        // url: myPref.role.val == "connector"
        //     ? APIConstants.connectionConnectorInbox
        //     : APIConstants.connectionInbox,
        // params: params.isNotEmpty ? params : null,
      );
      final connectionModel = ConnectionsModel.fromJson(response);
      incomingConnections.assignAll(connectionModel.connections ?? []);
      _filterByItemType();
      // statistics.value = connectionModel.statistics ?? Statistics();
      isLoader.value = false;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoader.value = false;
    }
  }

  Future<void> fetchOutgoingConnections({String? status, bool? isLoad}) async {
    try {
      isLoader.value = isLoad ?? true;
      final Map<String, dynamic> params = {};
      if (status != null) {
        params['status'] = status;
      }
      final response = await apiManager.get(
        url: APIConstants.outgoingConnectionInbox,
        // url: myPref.role.val == "connector"
        //     ? APIConstants.connectionConnectorInbox
        //     : APIConstants.connectionInbox,
        // params: params.isNotEmpty ? params : null,
      );
      final connectionModel = ConnectionsModel.fromJson(response);
      outgoingConnections.assignAll(connectionModel.connections ?? []);
      _filterByItemType();
      // statistics.value = connectionModel.statistics ?? Statistics();
      isLoader.value = false;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoader.value = false;
    }
  }

  void searchConnections(String value) {
    searchQuery.value = value;

    // List<Connection> typeFiltered = connections;
    // if (selectedTabIndex.value == 1) {
    //   typeFiltered = connections.where((connection) {
    //     return (connection.itemType?.toLowerCase() ?? 'unknown') == 'product';
    //   }).toList();
    // } else if (selectedTabIndex.value == 2) {
    //   typeFiltered = connections.where((connection) {
    //     return (connection.itemType?.toLowerCase() ?? 'unknown') == 'service';
    //   }).toList();
    // }

    if (value.isEmpty) {
      // filteredConnections.clear();
      // filteredConnections.addAll(typeFiltered);
    } else {
      filteredConnections.clear();
      //   filteredConnections.value = typeFiltered.where((connection) {
      //     return (connection.connectorName ?? '').toLowerCase().contains(
      //           value.toLowerCase(),
      //         ) ||
      //         (connection.productName ?? '').toLowerCase().contains(
      //           value.toLowerCase(),
      //         ) ||
      //         (connection.serviceName ?? '').toLowerCase().contains(
      //           value.toLowerCase(),
      //         ) ||
      //         (connection.requestMessage ?? '').toLowerCase().contains(
      //           value.toLowerCase(),
      //         ) ||
      //         (connection.merchantName ?? '').toLowerCase().contains(
      //           value.toLowerCase(),
      //         );
      //   }).toList();
    }
  }

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
    _filterByItemType();
  }

  void _filterByItemType() {
    if (selectedTabIndex.value == 0) {
      filteredConnections.clear();
      filteredConnections.addAll(incomingConnections);
    } else {
      filteredConnections.clear();
      filteredConnections.addAll(outgoingConnections);
      // final filterType = selectedTabIndex.value == 1 ? 'product' : 'service';
      // filteredConnections.clear();
      // filteredConnections.value = connections.where((connection) {
      //   return (connection.itemType?.toLowerCase() ?? 'unknown') == filterType;
      // }).toList();
    }
    if (searchQuery.value.isNotEmpty) {
      searchConnections(searchQuery.value);
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    _filterByItemType();
  }

  Future<void> acceptConnection(String connectionId) async {
    try {
      isLoading.value = true;
      final response = await apiManager.postObject(
        url: "${APIConstants.acceptReject}/accept",
        body: {"connectionId": connectionId},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection accepted successfully');
        await fetchIncomingConnections();
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to accept connection');
      }
    } catch (e) {
      // No need to show error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectConnection(String connectionId) async {
    try {
      isLoading.value = true;
      final response = await apiManager.postObject(
        url: "${APIConstants.acceptReject}/reject",
        body: {"connectionId": connectionId},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection rejected successfully');
        await fetchIncomingConnections();
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to reject connection');
      }
    } catch (e) {
      // No need to show error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeConnection(String connectionId) async {
    try {
      isLoading.value = true;

      final response = await apiManager.postObject(
        url: "${APIConstants.acceptReject}/remove",
        body: {"connectionId": connectionId},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection removed successfully');

        await fetchIncomingConnections();
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to remove connection');
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> blockConnection(String connectionId) async {
    try {
      isLoading.value = true;

      final response = await apiManager.postObject(
        url: "${APIConstants.acceptReject}/block",
        body: {"connectionId": connectionId},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'User blocked successfully');

        await fetchIncomingConnections();
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to block user');
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> withdrawRequest(String connectionId) async {
    try {
      isLoading.value = true;
      final response = await apiManager.postObject(
        url: APIConstants.connectionWithdrawRequest,
        body: {"connectionId": connectionId},
      );

      if (response['success'] == true) {
        SnackBars.successSnackBar(content: 'Connection withdraw  successfully');
        await fetchOutgoingConnections();
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to withdraw connection');
      }
    } catch (e) {
      // No need to show error
    } finally {
      isLoading.value = false;
    }
  }
}
