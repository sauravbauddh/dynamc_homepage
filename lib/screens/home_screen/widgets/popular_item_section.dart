import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thematic_ui/screens/home_screen/widgets/popular_items_card.dart';
import '../../../core/text_styling.dart';
import '../controller/home_controller.dart';

class PopularItemsSection extends StatelessWidget {
  const PopularItemsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
            child: Text(
              'Popular Right Now',
              style: gStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.popularItems.length,
            itemBuilder: (context, index) {
              final item = controller.popularItems[index];
              return PopularItemCard(
                item: item,
              );
            },
          ),
        ],
      ),
    );
  }
}
