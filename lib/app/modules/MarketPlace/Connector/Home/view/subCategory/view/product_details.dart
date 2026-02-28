import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Name",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              "Product ID: 4656717 9566",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ Product Images Row
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                        "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade200),
                        errorWidget: (context, url, error) =>
                            Container(color: Colors.grey.shade200),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// ✅ Dashed Divider
            _buildDashedDivider(),

            const SizedBox(height: 12),

            /// ✅ Flag + Name + Price + Stock
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  /// 🇮🇳 Flag
                  const Text("🇮🇳", style: TextStyle(fontSize: 22)),

                  const SizedBox(width: 8),

                  /// Name
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const Spacer(),

                  /// Price
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "₹50 ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "/ton",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// ✅ In Stock Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: const Text(
                      "In stock",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// ✅ Dashed Divider
            _buildDashedDivider(),

            const SizedBox(height: 8),

            /// ✅ Detail Rows with Icons
            _buildDetailRow(Icons.category_outlined, "Main Category", "Name"),
            _buildDetailRow(Icons.grid_view_outlined, "Category", "Name"),
            _buildDetailRow(Icons.layers_outlined, "Sub Category", "Name"),
            _buildDetailRow(Icons.grid_3x3_outlined, "Category", "Name"),
            _buildDetailRow(Icons.branding_watermark_outlined, "Brand", "Name"),
            _buildDetailRow(Icons.factory_outlined, "Ex Factory Price", "₹123/667"),
            _buildDetailRow(Icons.percent_outlined, "GST", "% 12"),
            _buildDetailRow(Icons.currency_rupee_outlined, "Ex Factory Rate", "₹756897"),
            _buildDetailRow(Icons.qr_code_outlined, "UPC", "4876876   9876787   9876787"),
            _buildDetailRow(Icons.tag_outlined, "HSN/HSC code", "4876876"),
            _buildDetailRow(Icons.straighten_outlined, "Package Size", "Name"),
            _buildDetailRow(Icons.inventory_2_outlined, "Package Type", "Name"),
            _buildDetailRow(Icons.monitor_weight_outlined, "Package Weight", "Name"),
            _buildDetailRow(Icons.shape_line_outlined, "Shape", "Name"),
            _buildDetailRow(Icons.texture_outlined, "Texture", "Name"),
            _buildDetailRow(Icons.color_lens_outlined, "Color", "Name"),
            _buildDetailRow(Icons.line_weight_outlined, "Thickness Mod.", "Name"),
            _buildDetailRow(Icons.water_outlined, "Fin Content", "Name"),
            _buildDetailRow(Icons.opacity_outlined, "Moisture Con.", "Name"),
            _buildDetailRow(Icons.compress_outlined, "Bulk Density", "Name"),
            _buildDetailRow(Icons.water_damage_outlined, "Water Abuse", "Name"),

            const SizedBox(height: 8),

            /// ✅ Description Rows
            _buildDescriptionRow(
              Icons.sticky_note_2_outlined,
              "Notes",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            ),
            _buildDescriptionRow(
              Icons.note_outlined,
              "Note",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.",
            ),

            const SizedBox(height: 16),

            /// ✅ Barcode
            Center(
              child: Row(
                children: [
                  const Icon(Icons.bar_chart_outlined, size: 16, color: Color(0xFF1B2F62)),
                  const Text(
                    "Bar-Code",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    children: [
                      Image.network(
                        "https://barcode.tec-it.com/barcode.ashx?data=463-769-3534&code=Code128",
                        height: 60,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 60,
                          width: 200,
                          color: Colors.grey.shade200,
                          child: const Center(child: Text("Barcode")),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "463-769-3534",
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      /// ✅ Connect Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF1B2F62),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Connect",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Detail Row with Icon
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: Colors.grey.shade100),
      //   ),
      // ),
      child: Row(
        children: [
          /// ✅ Icon
          Icon(icon, size: 16, color: const Color(0xFF1B2F62)),

          const SizedBox(width: 10),

          /// Label
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),

          /// Value
          Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // 👈 change your background color here
                  borderRadius: BorderRadius.circular(8), // rounded corners
                  // border: Border.all(
                  //   color: Colors.amber,               // optional border color
                  //   width: 1,
                  // ),
                ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Description Row with Icon
  Widget _buildDescriptionRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Icon
          Icon(icon, size: 16, color: const Color(0xFF1B2F62)),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Dashed Divider
  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 6.0;
          const dashSpace = 4.0;
          final dashCount =
          (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();
          return Row(
            children: List.generate(dashCount, (_) {
              return Container(
                width: dashWidth,
                height: 1.5,
                margin: const EdgeInsets.only(right: dashSpace),
                color: Colors.grey.shade300,
              );
            }),
          );
        },
      ),
    );
  }
}