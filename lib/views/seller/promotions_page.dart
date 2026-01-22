import 'package:app1/models/promotion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/models/product_model.dart';
import 'package:app1/controllers/promotion_controller.dart';
import 'package:app1/services/promotion_service.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromotionController()..loadPromotions(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Promotions"),
          backgroundColor: const Color(0xFFEFEFEF),
        ),
        body: Consumer<PromotionController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.promotions.isEmpty) {
              return const Center(child: Text('No promotions available'));
            }
            return ListView.builder(
              itemCount: controller.promotions.length,
              itemBuilder: (context, index) {
                final promotion = controller.promotions[index];
                final isActive = DateTime.now().isAfter(promotion.startDate) &&
                    DateTime.now().isBefore(promotion.endDate);
                return ListTile(
                  title: Text(promotion.title),
                  subtitle: Text(
                      'Discount: ${promotion.discountPercentage}% | Status: ${isActive ? 'Active' : 'Inactive'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.deletePromotion(promotion.id),
                  ),
                  onTap: () => _showPromotionDialog(context, controller,
                      promotion: promotion),
                );
              },
            );
          },
        ),
        floatingActionButton: Consumer<PromotionController>(
          builder: (context, controller, _) => FloatingActionButton(
            onPressed: () => _showPromotionDialog(context, controller),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _showPromotionDialog(
      BuildContext context, PromotionController controller,
      {Promotion? promotion}) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: promotion?.title);
    final descriptionController =
        TextEditingController(text: promotion?.description);
    final discountController =
        TextEditingController(text: promotion?.discountPercentage.toString());
    final productIdsController =
        TextEditingController(text: promotion?.productId);
    DateTime startDate = promotion?.startDate ?? DateTime.now();
    DateTime endDate =
        promotion?.endDate ?? DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(promotion == null ? 'Add Promotion' : 'Edit Promotion'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) => v!.isEmpty ? 'Title required' : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (v) => v!.isEmpty ? 'Description required' : null,
                ),
                TextFormField(
                  controller: discountController,
                  decoration: const InputDecoration(labelText: 'Discount %'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final d = double.tryParse(v!);
                    if (d == null || d <= 0 || d > 100) {
                      return 'Enter valid percentage (1-100)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: productIdsController,
                  decoration:
                      const InputDecoration(labelText: 'Product IDs (comma)'),
                  validator: (v) =>
                      v!.isEmpty ? 'At least one product ID' : null,
                ),
                ListTile(
                  title:
                      Text('Start Date: ${startDate.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) startDate = date;
                  },
                ),
                ListTile(
                  title: Text('End Date: ${endDate.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) endDate = date;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newPromotion = Promotion(
                  id: promotion?.id ?? DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  discountPercentage: double.parse(discountController.text),
                  startDate: startDate,
                  endDate: endDate,
                  productId: productIdsController.text,
                );
                if (promotion == null) {
                  controller.addPromotion(newPromotion);
                } else {
                  controller.updatePromotion(newPromotion);
                }
                Navigator.pop(context);
              }
            },
            child: Text(promotion == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }
}
