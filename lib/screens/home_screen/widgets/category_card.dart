import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/text_styling.dart';
import '../../../core/theme_controller.dart';
import '../controller/home_controller.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.index,
    this.onTap,
  }) : super(key: key);

  int _getThemeIndex(String theme) {
    switch (theme) {
      case 'diwali':
        return 1;
      case 'christmas':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final homeController = Get.find<HomeController>();

    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;
      final currentTheme = homeController.currentTheme.value;
      final themeIndex = _getThemeIndex(currentTheme);

      final imageUrl = category.imageUrls.length > themeIndex
          ? category.imageUrls[themeIndex]
          : category.imageUrls
              .first;

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildPlaceholder(isDarkMode),
                  errorWidget: (context, url, error) =>
                      _buildFallbackImage(isDarkMode),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDarkMode
                            ? Colors.black.withOpacity(0.2)
                            : Colors.white.withOpacity(0.2),
                        isDarkMode
                            ? Colors.black.withOpacity(0.7)
                            : Colors.white.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    category.name,
                    style: gStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPlaceholder(bool isDarkMode) {
    return Container(
      color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isDarkMode ? Colors.white70 : Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackImage(bool isDarkMode) {
    return Container(
      color: isDarkMode
          ? Colors.black.withOpacity(0.5)
          : Colors.white.withOpacity(0.5),
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 32,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
