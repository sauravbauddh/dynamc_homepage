import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/text_styling.dart';
import '../../../core/theme_controller.dart';
import '../models/item.dart';

class PopularItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;

  const PopularItemCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final imageUrl = _getFirstImage(item.imageUrls);

      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildImage(imageUrl, isDark),
              const SizedBox(width: 16),
              Expanded(
                child: _buildItemDetails(isDark),
              ),
            ],
          ),
        ),
      );
    });
  }

  String _getFirstImage(List<String>? imageUrls) {
    if (imageUrls != null && imageUrls.isNotEmpty) {
      return imageUrls.first;
    }
    return 'https://via.placeholder.com/150';
  }

  Widget _buildImage(String imageUrl, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 85,
        height: 85,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildImagePlaceholder(isDark),
        errorWidget: (context, url, error) => _buildImagePlaceholder(isDark),
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isDark) {
    return Container(
      width: 85,
      height: 85,
      color: isDark
          ? Colors.white.withOpacity(0.2)
          : Colors.black.withOpacity(0.1),
      child: const Icon(Icons.image_outlined, size: 30),
    );
  }

  Widget _buildItemDetails(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: gStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildRatingBadge(isDark),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '₹ ${item.price.toStringAsFixed(0)}/-',
          style: gStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBadge(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star_rounded,
            size: 14,
            color: isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 2),
          Text(
            item.rating.toStringAsFixed(1),
            style: gStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
