import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:thematic_ui/core/text_styling.dart';

import '../../../core/theme_controller.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final themeController = Get.find<ThemeController>();
  final List<String> searchHints = [
    'Search for products',
    'Find the best deals',
    'Explore categories',
    'Discover new arrivals',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: isDarkMode
              ? const LinearGradient(
                  colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFF6F6F6), Color(0xFFECECEC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.2),
              offset: const Offset(2, 4),
              blurRadius: 6,
            ),
          ],
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: isDarkMode ? Colors.white : Colors.grey.shade600,
              size: 24.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: AnimatedTextKit(
                animatedTexts: searchHints
                    .map(
                      (hint) => FadeAnimatedText(
                        hint,
                        textStyle: gStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode ? Colors.white : Colors.grey.shade800,
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    )
                    .toList(),
                isRepeatingAnimation: true,
                repeatForever: true,
                displayFullTextOnTap: true,
                pause: const Duration(milliseconds: 700),
              ),
            ),
          ],
        ),
      );
    });
  }
}
