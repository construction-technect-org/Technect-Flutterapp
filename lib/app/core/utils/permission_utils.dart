import 'package:construction_technect/main.dart';

class PermissionKeys {
  static const String catalogManager = 'catalog_manager';
  static const String connectionManager = 'connection_manager';
  static const String marketingLeadManager = 'marketing_lead_manager';
  static const String salesLeadManager = 'sales_lead_manager';
  static const String accountLeadManager = 'account_lead_manager';
  static const String crmAddLead = 'crm_add_lead';

  static const List<String> all = [
    catalogManager,
    connectionManager,
    marketingLeadManager,
    salesLeadManager,
    accountLeadManager,
    crmAddLead,
  ];
}

class PermissionLabelUtils {
  static const Map<String, String> _permissionLabels = {
    PermissionKeys.catalogManager: 'Catalog Manager',
    PermissionKeys.connectionManager: 'Connection Manager',
    PermissionKeys.marketingLeadManager: 'Marketing Lead Manager',
    PermissionKeys.salesLeadManager: 'Sales Lead Manager',
    PermissionKeys.accountLeadManager: 'Account Lead Manager',
    PermissionKeys.crmAddLead: 'CRM Add Lead',
  };

  static List<PermissionItem> get permissionItems => _permissionLabels.entries
      .map((e) => PermissionItem(key: e.key, label: e.value))
      .toList();

  static String format(String? apiValue) {
    if (apiValue == null || apiValue.isEmpty) return '';

    return apiValue
        .split(',')
        .map((key) => _permissionLabels[key.trim()] ?? key)
        .join(', ');
  }

  static bool canShow(String permission) {
    if (!myPref.getIsTeamLogin()) return true;
    return myPref.getPermissionList().contains(permission);
  }

  static bool canShowAny(List<String> permissions) {
    if (!myPref.getIsTeamLogin()) return true;
    return permissions.any(myPref.getPermissionList().contains);
  }

  static bool canShowAll(List<String> permissions) {
    if (!myPref.getIsTeamLogin()) return true;
    return permissions.every(myPref.getPermissionList().contains);
  }
}

class PermissionItem {
  final String label;
  final String key;

  PermissionItem({required this.label, required this.key});
}
