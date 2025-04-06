import 'package:flutter/material.dart';
import 'package:app1/controllers/product_controller.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productController = ProductController();

  String _productName = '';
  String? _productCategory;
  double _price = 0.0;
  String _description = '';

  void _uploadImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image upload feature coming soon!')),
    );
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        final productData = {
          'name': _productName,
          'category': _productCategory,
          'price': _price,
          'description': _description,
        };

        await _productController.addProduct(productData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Product "$_productName" added successfully!')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _productName = '';
          _productCategory = null;
          _price = 0.0;
          _description = '';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        backgroundColor: const Color(0xFF2F3861),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() {
                  _productName = value;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                value: _productCategory,
                items: ['Category 1', 'Category 2', 'Category 3']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _productCategory = value;
                }),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  _price = double.tryParse(value) ?? 0.0;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) => setState(() {
                  _description = value;
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F3861),
                ),
                onPressed: _uploadImage,
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F3861),
                ),
                onPressed: _addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
