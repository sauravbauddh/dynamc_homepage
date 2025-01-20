import 'package:get/get.dart';
import '../screens/home_screen/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
    ),
  ];
}
