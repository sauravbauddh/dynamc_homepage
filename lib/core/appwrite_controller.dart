import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import '../network/api_end_points.dart';

class AppWriteController extends GetxController {
  late Client client;
  final String bucketId = '678d8f0200111942dd70';
  final String projectId = '678d8ea6000d58fd3a83';
  final String dbId = '678d8faf00328413aaea';
  final String categoriesCollectionId = '678d8fb900179ecfcd11';
  final String bannerInfoCollectionId = '678d91db000ee53c666b';
  final String popularItemsCollectionId = '678da4cf00278034ff44';
  final String dealsCollectionId = '678da1650028faa02a0b';

  @override
  void onInit() {
    super.onInit();
    client = Client()
      ..setProject(projectId)
      ..setEndpoint(ApiEndPoints.appWriteBaseUrl);
  }

  Future<DocumentList> getDocumentList(String collectionId) async {
    Databases databases = Databases(client);
    return await databases.listDocuments(
      collectionId: collectionId,
      databaseId: dbId,
    );
  }

  Future<DocumentList> getBannerInfo() async {
    return await getDocumentList(bannerInfoCollectionId);
  }

  Future<DocumentList> getCategoryInfo() async {
    return await getDocumentList(categoriesCollectionId);
  }

  Future<DocumentList> getPopularItems() async {
    return await getDocumentList(popularItemsCollectionId);
  }

  Future<DocumentList> getDeals() async {
    return await getDocumentList(dealsCollectionId);
  }

  String getFileUrl(String fileId) {
    return '${client.endPoint}/storage/buckets/$bucketId/files/$fileId/view?project=$projectId';
  }
}
