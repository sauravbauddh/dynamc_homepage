import 'package:get/get.dart';
import 'package:thematic_ui/screens/home_screen/models/category.dart';
import 'package:thematic_ui/screens/home_screen/models/deal.dart';
import 'package:thematic_ui/screens/home_screen/models/item.dart';
import '../../../core/appwrite_controller.dart';

class HomeController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isBannerLoading = true.obs;
  final RxString currentBannerId = ''.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ItemModel> popularItems = <ItemModel>[].obs;
  final RxList<DealModel> deals = <DealModel>[].obs;
  final appWriteController = Get.find<AppWriteController>();
  final RxString currentTheme = 'normal'.obs;

  static const Map<String, String> themeNames = {
    'normal': 'Normal',
    'diwali': 'Diwali',
    'christmas': 'Christmas',
  };

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        _fetchBannerForTheme(),
        _fetchCategories(),
        _fetchPopularItems(),
        _fetchDeals(),
      ]);
    } catch (e) {
      _handleError('Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchBannerForTheme() async {
    isBannerLoading.value = true;
    isLoading.value = true;
    try {
      final bannerDocs = await appWriteController.getBannerInfo();
      if (bannerDocs.documents.isNotEmpty) {
        currentBannerId.value = _findMatchingBanner(bannerDocs.documents);
      }
    } catch (e) {
      print('Error fetching banner: $e');
    } finally {
      isBannerLoading.value = false;
      isLoading.value = false;
    }
  }

  String _findMatchingBanner(List<dynamic> banners) {
    final matchingBanner = banners.firstWhereOrNull(
      (doc) => doc.data['name']
          .toString()
          .toLowerCase()
          .contains(currentTheme.value),
    );
    final fallbackBanner = banners.firstWhereOrNull(
      (doc) => doc.data['name'].toString().toLowerCase().contains('normal'),
    );
    final bannerId =
        matchingBanner?.data['bannerId'] ?? fallbackBanner?.data['bannerId'];
    return bannerId != null ? appWriteController.getFileUrl(bannerId) : '';
  }

  Future<void> _fetchCategories() async {
    try {
      final categoryDocs = await appWriteController.getCategoryInfo();
      categories.value = categoryDocs.documents
          .map((doc) => CategoryModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> _fetchPopularItems() async {
    try {
      final popularItemsDocs = await appWriteController.getPopularItems();
      popularItems.value = popularItemsDocs.documents
          .map((doc) => ItemModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      print('Error fetching popular items: $e');
    }
  }

  Future<void> _fetchDeals() async {
    try {
      final dealsDocs = await appWriteController.getDeals();
      deals.value = dealsDocs.documents
          .map((doc) => DealModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      print('Error fetching deals: $e');
    }
  }

  Future<void> changeTheme(String themeId) async {
    if (currentTheme.value != themeId && themeNames.containsKey(themeId)) {
      currentTheme.value = themeId;
      await _fetchBannerForTheme();
    }
  }

  Future<void> refreshData() async {
    await fetchInitialData();
  }

  void _handleError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
