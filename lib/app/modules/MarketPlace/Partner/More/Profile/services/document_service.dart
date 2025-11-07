import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class DocumentService {
  final ApiManager _apiManager = ApiManager();

  Future<DeleteDocumentResponse> deleteDocument(int documentId) async {
    try {
      final response = await _apiManager.delete(
        url: '${APIConstants.deleteDocument}$documentId',
      );
      return DeleteDocumentResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> viewDocument(Documents document) async {
    try {
      if (document.filePath != null) {
        final url = Uri.parse(APIConstants.bucketUrl + document.filePath!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Cannot open document');
        }
      } else {
        throw Exception('Document path not available');
      }
    } catch (e) {
      rethrow;
    }
  }

  String getDocumentDisplayName(String? documentType) {
    switch (documentType) {
      case 'business_license':
        return 'GST';
      case 'identity_certificate':
        return 'UDYAM';
      default:
        return documentType ?? 'Document';
    }
  }
}
