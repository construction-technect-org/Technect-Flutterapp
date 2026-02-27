import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Projects/controllers/project_detail_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Projects/views/projects_view.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            _buildProfileHeader(),
            _buildProjectDetails(),
            const SizedBox(height: 20),
            _buildConnectButton(),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: const ProjectsBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      title: Column(
        children: [
          Obx(
            () => Text(
              controller.projectData['projectName']!,
              style: MyTexts.medium18.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => Text(
              "Project ID - ${controller.projectData['projectId']}",
              style: MyTexts.regular12.copyWith(color: const Color(0xFF1B2F62).withOpacity(0.6)),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery() {
    final List<String> images = [Asset.explore, Asset.explore, Asset.explore];

    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(radius: 35, backgroundImage: AssetImage(Asset.profil)),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.projectData['projectName']!,
                      style: MyTexts.regular12.copyWith(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Name",
                    style: MyTexts.medium16.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDetails() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            Icons.file_present_outlined,
            "Project Code",
            controller.projectData['projectCode']!,
          ),
          _buildDetailRow(
            Icons.layers_outlined,
            "Project Area",
            controller.projectData['projectArea']!,
          ),
          _buildDetailRow(
            Icons.location_on_outlined,
            "Address",
            controller.projectData['address']!,
          ),
          _buildDetailRow(
            Icons.apartment_outlined,
            "No. of Floors",
            controller.projectData['floors']!,
          ),
          _buildDetailRow(
            Icons.category_outlined,
            "Project type",
            controller.projectData['projectType']!,
          ),
          _buildDetailRow(
            Icons.info_outline,
            "Project Status",
            controller.projectData['projectStatus']!,
          ),
          _buildDetailRow(
            Icons.description_outlined,
            "Description",
            controller.projectData['description']!,
            isMultiline: true,
          ),
          _buildDetailRow(
            Icons.note_alt_outlined,
            "Note",
            controller.projectData['note']!,
            isMultiline: true,
          ),
          _buildBarcodeSection(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          SizedBox(
            width: 90,
            child: Text(label, style: MyTexts.regular14.copyWith(color: Colors.grey)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(value, style: MyTexts.medium14.copyWith(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.view_column_outlined, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          SizedBox(
            width: 90,
            child: Text("Bar-code", style: MyTexts.regular14.copyWith(color: Colors.grey)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://www.pngkit.com/png/full/18-185449_barcode-clip-art-black-and-white-barcode.png",
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    controller.projectData['barcode']!,
                    style: MyTexts.medium16.copyWith(letterSpacing: 2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF1B2F62)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          "Connect",
          style: MyTexts.medium16.copyWith(
            color: const Color(0xFF1B2F62),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
