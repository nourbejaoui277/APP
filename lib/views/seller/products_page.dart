import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/models/product_model.dart';
import 'package:app1/controllers/product_controller.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductController()..loadProducts(),
      child: Consumer<ProductController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
              backgroundColor: const Color(0xFFEFEFEF),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showProductDialog(context, controller),
              child: const Icon(Icons.add),
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('${product.price} TND'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showProductDialog(
                                context,
                                controller,
                                product: product,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  controller.deleteProduct(product.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  static final Map<String, List<String>> _categories = {
    "Men": [
      "Tops",
      "Bottoms",
      "Outerwear",
      "Sportswear",
      "Footwear",
      "Accessories",
      "Bags",
      "Swimwear",
      "Sleepwear",
      "Traditional/Cultural Wear",
      "Sets & Outfits"
    ],
    "Women": [
      "Tops",
      "Bottoms",
      "Dresses",
      "Outerwear",
      "Sportswear",
      "Footwear",
      "Accessories",
      "Bags",
      "Jewelry",
      "Swimwear",
      "Sleepwear",
      "Traditional/Cultural Wear",
      "Sets & Outfits"
    ],
    "Kids": [
      "Tops",
      "Bottoms",
      "Dresses",
      "Outerwear",
      "Sportswear",
      "Footwear",
      "Accessories",
      "Bags",
      "Swimwear",
      "Sleepwear",
      "Traditional/Cultural Wear",
      "Sets & Outfits",
      "Babywear",
      "School & Supplies"
    ]
  };

  static final Map<String, int> _sectionIds = {
    "Men": 1,
    "Women": 2,
    "Kids": 3,
  };

  void _showProductDialog(BuildContext context, ProductController controller,
      {Product? product}) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: product?.name ?? '');
    final _descriptionController =
        TextEditingController(text: product?.description ?? '');
    final _priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    final _stockController =
        TextEditingController(text: product?.stock.toString() ?? '');
    final _boutiqueIdController =
        TextEditingController(text: product?.boutiqueId.toString() ?? '');

    // Initialize section and category based on product or default
    String? _selectedSection = product != null
        ? _sectionIds.entries
            .firstWhere((entry) => entry.value == product.sectionId,
                orElse: () => const MapEntry("Men", 1))
            .key
        : "Men";
    String? _selectedCategory = product != null
        ? _categories[_selectedSection]!
            .asMap()
            .entries
            .firstWhere((entry) => entry.key + 1 == product.categoryId,
                orElse: () => MapEntry(0, _categories[_selectedSection]![0]))
            .value
        : _categories[_selectedSection]![0];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(_nameController, 'Name'),
                  _buildTextField(_descriptionController, 'Description'),
                  _buildTextField(_priceController, 'Price', isNumber: true),
                  _buildTextField(_stockController, 'Stock', isNumber: true),
                  _buildTextField(_boutiqueIdController, 'Boutique ID',
                      isNumber: true),
                  _buildDropdownField(
                    label: 'Section',
                    value: _selectedSection,
                    items: _sectionIds.keys.toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSection = value;
                        _selectedCategory = _categories[value]![0];
                      });
                    },
                  ),
                  _buildDropdownField(
                    label: 'Category',
                    value: _selectedCategory,
                    items: _categories[_selectedSection]!,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newProduct = Product(
                    id: product?.id ?? '',
                    name: _nameController.text,
                    description: _descriptionController.text,
                    price: num.parse(_priceController.text),
                    stock: int.parse(_stockController.text),
                    boutiqueId: int.parse(_boutiqueIdController.text),
                    sectionId: _sectionIds[_selectedSection]!,
                    categoryId: _categories[_selectedSection]!
                            .indexOf(_selectedCategory!) +
                        1,
                  );
                  if (product == null) {
                    controller.addProduct(newProduct);
                  } else {
                    controller.updateProduct(newProduct);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select a $label' : null,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
