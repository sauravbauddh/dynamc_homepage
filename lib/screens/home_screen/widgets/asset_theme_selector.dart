import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme_controller.dart';
import '../controller/home_controller.dart';

class ThemeSelector extends StatelessWidget {
  ThemeSelector({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.grey[850]!.withOpacity(0.8)
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDark ? Colors.grey[850] : Colors.white,
          offset: const Offset(0, 40),
          onSelected: controller.changeTheme,
          itemBuilder: (BuildContext context) =>
              HomeController.themeNames.entries
                  .map((entry) => PopupMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            _buildThemeIcon(entry.key),
                            const SizedBox(width: 8),
                            Text(
                              entry.value,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThemeIcon(controller.currentTheme.value),
                const SizedBox(width: 8),
                Text(
                  HomeController.themeNames[controller.currentTheme.value] ??
                      'Normal',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildThemeIcon(String themeId) {
    switch (themeId) {
      case 'christmas':
        return const Icon(Icons.celebration, size: 20, color: Colors.red);
      case 'diwali':
        return const Icon(Icons.light, size: 20, color: Colors.orange);
      default:
        return const Icon(Icons.home, size: 20, color: Colors.blue);
    }
  }
}
