import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thematic_ui/core/theme_controller.dart';
import 'package:thematic_ui/routes/app_pages.dart';
import 'package:thematic_ui/screens/home_screen/controller/home_controller.dart';

import 'core/appwrite_controller.dart';
import 'network/storage_service.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  Get.put(AppWriteController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.put(ThemeController());
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.HOME,
        getPages: AppPages.routes,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
