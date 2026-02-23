import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/inventory_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class InventoryService {
  ApiManager apiManager = ApiManager();

  Future<ProductListModel> getInventoryProducts() async {
    try {
      final response = await apiManager.get(url: APIConstants.getProductList);
      return ProductListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getInventoryProducts: $e , $st');
    }
  }

  Future<AllServiceModel> getServiceList() async {
    try {
      final response = await apiManager.get(url: APIConstants.getServiceList);
      return AllServiceModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getServiceList: $e , $st');
    }
  }

  /// Creates an inventory product.
  /// Files are sent as repeated `files` multipart fields (not image_1, image_2).
  Future<Map<String, dynamic>> createInventoryProduct({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
    List<String> filePaths = const [],
  }) async {
    return _postWithFiles(
      url: APIConstants.merchantInventoryProducts,
      fields: fields,
      filePaths: filePaths,
    );
  }

  /// Creates a generic service inventory item.
  Future<Map<String, dynamic>> createInventoryGeneric({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
    List<String> filePaths = const [],
  }) async {
    return _postWithFiles(
      url: APIConstants.merchantInventoryGeneric,
      fields: fields,
      filePaths: filePaths,
    );
  }

  /// Builds a multipart POST where all images share the field name "files".
  /// The server treats repeated "files" fields as an array.
  Future<Map<String, dynamic>> _postWithFiles({
    required String url,
    required Map<String, dynamic> fields,
    List<String> filePaths = const [],
  }) async {
    try {
      final token = myPref.getToken();
      final request = http.MultipartRequest('POST', Uri.parse('${ApiManager.baseUrl}$url'));
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields (skip nulls)
      fields.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty) {
          request.fields[key] = value.toString();
        }
      });

      // Add each file under the key "files" — repeated fields = array on backend
      for (final path in filePaths) {
        if (path.isEmpty || path.startsWith('http')) continue;
        final file = File(path);
        if (!file.existsSync()) continue;
        final fileName = file.path.split('/').last;
        final ext = fileName.split('.').last.toLowerCase();
        request.files.add(
          await http.MultipartFile.fromPath(
            'files',
            path,
            filename: fileName,
            contentType: MediaType.parse(_mimeFromExt(ext)),
          ),
        );
      }

      log('🌐 POST Inventory — URL: ${ApiManager.baseUrl}$url');
      log('   Fields: $fields');
      log('   File count: ${filePaths.length}');

      final streamed = await request.send();
      final responseString = await streamed.stream.bytesToString();

      log('📡 Status: ${streamed.statusCode}');
      log('📦 Body: $responseString');

      return jsonDecode(responseString) as Map<String, dynamic>;
    } catch (e, st) {
      log('❌ Error in _postWithFiles: $e\n$st');
      rethrow;
    }
  }

  String _mimeFromExt(String ext) {
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      default:
        return 'application/octet-stream';
    }
  }

  // Fetch unified inventory list (Products/Services/etc)
  Future<InventoryListResponse> fetchInventoryItems({
    String? inventoryType,
    String? categoryProductId,
    bool? inStockOnly,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (inventoryType != null && inventoryType.isNotEmpty) {
        queryParameters['inventoryType'] = inventoryType;
      }
      if (categoryProductId != null && categoryProductId.isNotEmpty) {
        queryParameters['categoryProductId'] = categoryProductId;
      }
      if (inStockOnly != null) {
        queryParameters['inStockOnly'] = inStockOnly.toString();
      }

      final response = await apiManager.get(
        url: APIConstants.merchantInventoryProducts,
        params: queryParameters,
      );

      return InventoryListResponse.fromJson(response);
    } catch (e) {
      log('Error fetching inventory items', error: e);
      return InventoryListResponse(success: false);
    }
  }
}
