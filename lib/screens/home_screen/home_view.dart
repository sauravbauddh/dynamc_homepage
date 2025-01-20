import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thematic_ui/core/text_styling.dart';
import 'package:thematic_ui/screens/home_screen/widgets/asset_theme_selector.dart';
import 'package:thematic_ui/screens/home_screen/widgets/category_card.dart';
import 'package:thematic_ui/screens/home_screen/widgets/custom_card.dart';
import 'package:thematic_ui/screens/home_screen/widgets/custom_search_bar.dart';
import 'package:thematic_ui/screens/home_screen/widgets/popular_item_section.dart';
import 'package:thematic_ui/screens/home_screen/widgets/shimmer_loading.dart';
import 'package:thematic_ui/screens/home_screen/widgets/user_info_section.dart';

import '../../core/theme_controller.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;
  final themeController = Get.find<ThemeController>();

  @override
  initState() {
    super.initState();
    controller = Get.find<HomeController>();
    fetchData();
  }

  fetchData() async {
    await controller.fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? _buildLoadingState()
            : RefreshIndicator(
                onRefresh: controller.refreshData,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildHeaderSection(Get.height, Get.width),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Categories",
                                style: gStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _buildCategoriesGrid(),
                            const SizedBox(height: 24),
                            _buildPopularItems(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeaderSection(double screenHeight, double screenWidth) {
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.6,
          width: screenWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Stack(
            children: [
              _buildBackgroundImage(screenHeight, screenWidth),
              _buildGradientOverlay(),
              _buildHeaderContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return ShimmerLoadingState();
  }

  Widget _buildBackgroundImage(double screenHeight, double screenWidth) {
    final fallbackAsset = themeController.isDarkMode.value
        ? 'assets/images/dark.png'
        : 'assets/images/light.png';
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    );

    if (controller.isBannerLoading.value ||
        controller.currentBannerId.value.isEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          fallbackAsset,
          width: screenWidth,
          height: screenHeight * 0.7,
          fit: BoxFit.cover,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: controller.currentBannerId.value,
        width: screenWidth,
        height: screenHeight * 0.7,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 500),
        placeholder: (context, url) => Image.asset(
          fallbackAsset,
          width: screenWidth,
          height: screenHeight * 0.7,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          fallbackAsset,
          width: screenWidth,
          height: screenHeight * 0.7,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.1),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: UserInfoSection()),
                ThemeSelector(),
              ],
            ),
            const SizedBox(height: 24),
            const CustomSearchBar(),
            const SizedBox(height: 16),
            _buildDealsSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Best Deals',
          style: gStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.deals.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final deal = controller.deals[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index != controller.deals.length - 1 ? 12 : 0,
                ),
                child: CustomCard(
                  deal: deal,
                  fallbackAsset: 'assets/images/deal.jpg',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        return Obx(() {
          final category = controller.categories[index];
          return _buildCategoryItem(category, index);
        });
      },
    );
  }

  Widget _buildPopularItems() {
    return const PopularItemsSection();
  }

  Widget _buildCategoryItem(category, int index) {
    return CategoryCard(
      category: category,
      index: index,
      onTap: () {},
    );
  }
}
