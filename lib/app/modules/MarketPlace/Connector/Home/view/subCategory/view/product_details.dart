import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/connector_product_detail_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/product_detail_controller.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              title: Obx(() {
                if (controller.isLoading.value) return const SizedBox.shrink();
                final product = controller.productDetails.value;
                return Column(
                  children: [
                    Text(
                      product?.name ?? "Product Name",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (product?.id != null)
                      Text(
                        "Product ID. - #${product!.id!.substring(0, 8)}",
                        style: const TextStyle(fontSize: 10, color: Color(0xFF1B2F62)),
                      ),
                  ],
                );
              }),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black, size: 18),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.grey.shade100),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        final product = controller.productDetails.value;
        if (product == null) {
          return const Center(child: Text("No product details available."));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SizedBox(height: 120, child: _buildImageGallery(product)),
              const SizedBox(height: 16),
              _buildHeaderCard(product),
              const SizedBox(height: 16),
              _buildDetailsContainer(product),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value) return const SizedBox.shrink();
        final product = controller.productDetails.value;
        if (product == null) return const SizedBox.shrink();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: GestureDetector(
              onTap: () {
                if (!controller.isConnecting.value) {
                  controller.showConnectConfirmationDialog();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:
                      controller.connectionStatus.value == 'Requested' ||
                          controller.connectionStatus.value == 'Connected'
                      ? Colors.grey
                      : const Color(0xFF1B2F62),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: controller.isConnecting.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          controller.connectionStatus.value,
                          style: const TextStyle(
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
      }),
    );
  }

  Widget _buildImageGallery(ConnectorProductDetail product) {
    final images = product.images;
    if (images == null || images.isEmpty) {
      return Container(
        color: Colors.grey.shade100,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: const Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey)),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: images.length,
      itemBuilder: (context, index) {
        String imageUrl = images[index].url;
        if (imageUrl.isNotEmpty && !imageUrl.startsWith("http")) {
          imageUrl = APIConstants.bucketUrl + imageUrl;
        }
        return Container(
          width: 120,
          margin: const EdgeInsets.only(right: 8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => ColoredBox(color: Colors.grey.shade200),
            errorWidget: (context, url, error) => ColoredBox(
              color: Colors.grey.shade100,
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard(ConnectorProductDetail product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: const Center(
                  child: Icon(Icons.account_balance, color: Colors.red, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Brand", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(
                    product.brand ?? "",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF5), // Very faint yellow/orange hue
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.yellow.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ex-factory Price",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "₹${product.price ?? '0'}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${product.gstPercentage ?? '0'}% GST",
                          style: const TextStyle(fontSize: 10, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              (product.stock ?? 0) > 0 || (product.isAvailable == true)
                  ? "In stock"
                  : "Out of stock",
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContainer(ConnectorProductDetail product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade100, width: 1.0),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.inbox_outlined, "Shipping Addr...", "-"),
          _buildInfoRow(
            Icons.inbox_outlined,
            "Main Category",
            "-",
          ), // No main category in product model directly
          _buildInfoRow(Icons.inbox_outlined, "Category", product.categoryProduct?.name ?? "-"),
          _buildInfoRow(Icons.inbox_outlined, "Sub Category", "-"),
          _buildInfoRow(Icons.inbox_outlined, "Product", product.name ?? "-"),
          _buildInfoRow(Icons.inbox_outlined, "Brand", product.brand ?? "-"),
          _buildInfoRow(
            Icons.monetization_on_outlined,
            "Ex Factory Price",
            "₹${product.price ?? '1234567'}",
          ),
          _buildInfoRow(Icons.percent_outlined, "GST", "% ${product.gstPercentage ?? '12'}"),
          _buildInfoRow(
            Icons.account_balance_wallet_outlined,
            "GST Price",
            "₹${product.gstAmount ?? '1234567'}",
          ),
          _buildInfoRow(
            Icons.shopping_bag_outlined,
            "Ex Factory Rate",
            "₹${product.finalPrice ?? '1234567'}",
          ),
          _buildInfoRow(
            Icons.straighten_outlined,
            "UOM",
            product.productDetails?.uom ?? "68768767",
          ),

          _buildUocRow(Icons.compare_arrows_outlined, "UOC", product.productDetails?.uoc),

          _buildInfoRow(Icons.qr_code_outlined, "HSN/SAC code", "68768767"),
          _buildInfoRow(
            Icons.format_size_outlined,
            "Package Size",
            product.productDetails?.size ?? "-",
          ),
          _buildInfoRow(
            Icons.inventory_2_outlined,
            "Package Type",
            product.productDetails?.packageType ?? "-",
          ),
          _buildInfoRow(Icons.monitor_weight_outlined, "Package Weight", "-"),
          _buildInfoRow(Icons.shape_line_outlined, "Shape", product.productDetails?.shape ?? "-"),
          _buildInfoRow(Icons.texture_outlined, "Texture", product.productDetails?.texture ?? "-"),
          _buildInfoRow(Icons.color_lens_outlined, "Color", product.productDetails?.colour ?? "-"),
          _buildInfoRow(Icons.grain_outlined, "Grain Size", "-"),
          _buildInfoRow(
            Icons.line_weight_outlined,
            "Fineness Mod...",
            product.productDetails?.finenessModules ?? "-",
          ),
          _buildInfoRow(
            Icons.blur_on_outlined,
            "Slit Content",
            product.productDetails?.siltContent ?? "-",
          ),
          _buildInfoRow(
            Icons.landscape_outlined,
            "Clay & Dust ...",
            product.productDetails?.clayDustContent ?? "-",
          ),
          _buildInfoRow(
            Icons.water_drop_outlined,
            "Moisture Con...",
            product.productDetails?.moistureContent ?? "-",
          ),
          _buildInfoRow(
            Icons.compress_outlined,
            "Bulk Density",
            product.productDetails?.bulkDensity ?? "-",
          ),
          _buildInfoRow(
            Icons.water_damage_outlined,
            "Water Absor...",
            product.productDetails?.waterAbsorption ?? "-",
          ),

          _buildMultiLineRow(Icons.description_outlined, "Description", product.description ?? "-"),
          _buildMultiLineRow(
            Icons.sticky_note_2_outlined,
            "Note",
            product.productDetails?.note ?? "-",
          ),

          // _buildBarcodeRow(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLineRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(icon, size: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUocRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: _buildUocPill(value ?? "68768767")),
                const SizedBox(width: 6),
                Expanded(child: _buildUocPill("68768767")),
                const SizedBox(width: 6),
                Expanded(child: _buildUocPill("68768767")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUocPill(String val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        val,
        style: const TextStyle(fontSize: 9, color: Colors.black54),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBarcodeRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.view_column_outlined, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          const Expanded(
            flex: 2,
            child: Text("Bar-code", style: TextStyle(fontSize: 11, color: Colors.black87)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/UPC-A-036000291452.svg/1200px-UPC-A-036000291452.svg.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "463-789-1234",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
