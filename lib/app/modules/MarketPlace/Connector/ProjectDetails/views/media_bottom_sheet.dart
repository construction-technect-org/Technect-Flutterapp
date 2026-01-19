import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/controllers/edit_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaBottomSheet extends GetView<EditProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        children: [
          const Text(
            "Add Media",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Add Image"),
            onTap: () {
              Get.back();
              controller.pickImages();
            },
          ),

          ListTile(
            leading: const Icon(Icons.video_collection),
            title: const Text("Add Video"),
            onTap: () {
              Get.back();
              controller.pickVideo();
            },
          ),

          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text("Add PDF"),
            onTap: () {
              Get.back();
              controller.pickPDF();
            },
          ),

          const SizedBox(height: 10),
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ],
      ),
    );
  }
}
