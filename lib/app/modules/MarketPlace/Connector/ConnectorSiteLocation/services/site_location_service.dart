import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/models/add_site_address_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/models/site_location_model.dart';

class SiteLocationService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddSiteAddressModel> submitSiteLocation(
    Map<String, dynamic> siteLocation,
  ) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.connectorSiteAddress,
        body: siteLocation,
      );
      return AddSiteAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error Add site address: $e');
    }
  }

  static Future<SiteAddressModel> getSiteLocations() async {
    try {
      final response = await _apiManager.get(url: APIConstants.connectorSiteAddress);

      return SiteAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching Site address: $e');
    }
  }

  static Future<AddSiteAddressModel> deleteSiteLocation(String siteId) async {
    try {
      final response = await _apiManager.delete(
        url: '${APIConstants.connectorSiteAddress}/$siteId',
      );

      return AddSiteAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching Site address: $e');
    }
  }

  static Future<AddSiteAddressModel> updateSiteLocation(
    String siteId,
    Map<String, dynamic> siteLocation,
  ) async {
    try {
      final response = await _apiManager.putObject(
        url: '${APIConstants.connectorSiteAddress}/$siteId',
        body: siteLocation,
      );

      return AddSiteAddressModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching Site address: $e');
    }
  }
}
