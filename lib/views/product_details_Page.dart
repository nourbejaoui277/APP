import 'package:app1/services/product_details_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_details_controller.dart';
import '../models/product_details_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Productdetails productDetails;

  ProductDetailsPage({Key? key, required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailsController(
        productService: ProductdetailsService(baseUrl: ''),
        product: productDetails,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(productDetails.name),
        ),
        body: Consumer<ProductDetailsController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Center(
                    child: Image.asset(
                      productDetails.imageUrl,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Name
                  Text(
                    productDetails.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Price
                  Text(
                    "\TND${productDetails.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Quantity Selector
                  Row(
                    children: [
                      const Text('Quantity:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: controller.decrementQuantity,
                      ),
                      Text(
                        controller.quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: controller.incrementQuantity,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Description
                  Text(
                    productDetails.description ?? 'No description available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Rating Section
                  const Text(
                    'Rate this product:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      int starNumber = index + 1;
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          size: 30,
                          color: controller.userRating >= starNumber
                              ? Colors.amber
                              : Colors.grey,
                        ),
                        onPressed: () {
                          controller.userRating = starNumber;
                          controller.notifyListeners();
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: controller.userRating > 0
                        ? () => controller.submitRating(
                              controller.userRating.toDouble(),
                              context,
                            )
                        : null,
                    child: const Text('Submit Rating'),
                  ),
                  const SizedBox(height: 16),
                  if (controller.message.isNotEmpty)
                    Text(
                      controller.message,
                      style: TextStyle(
                        color: controller.message.contains('success')
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
