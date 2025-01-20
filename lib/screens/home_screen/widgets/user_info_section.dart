import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thematic_ui/core/text_styling.dart';
import '../../../core/theme_controller.dart';
import '../controller/user_info_controller.dart';

class UserInfoSection extends StatelessWidget {
  UserInfoSection({super.key});

  final UserInfoController controller = Get.put(UserInfoController());
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDeliveryInfo(),
                const SizedBox(height: 8),
                _buildDeliveryTime(),
                const SizedBox(height: 4),
                _buildAddress(),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Obx(() => _buildThemeToggle(themeController.isDarkMode.value)),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time_rounded,
            size: 16,
          ),
          const SizedBox(width: 4),
          Obx(
                () => Text(
              "Delivery in",
              style: gStyle(
                fontSize: 12,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDeliveryTime() {
    return Obx(
          () => Text(
        "${controller.deliveryTime} min",
        style: gStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Obx(
          () => Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            size: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              controller.address.value,
              style: gStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Colors.grey[850]!, Colors.grey[900]!]
              : [Colors.white, Colors.grey[100]!],
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black38 : Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 26,
        ),
        color: isDark ? Colors.amber : Colors.indigo,
        onPressed: () => themeController.toggleTheme(),
      ),
    );
  }
}
