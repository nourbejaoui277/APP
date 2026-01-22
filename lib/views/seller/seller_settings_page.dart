import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/controllers/seller_settings_controller.dart';
import 'package:app1/models/boutique.dart';
import 'package:app1/models/seller_settings_model.dart';

class SellerSettingsPage extends StatelessWidget {
  final String userId;
  final String boutiqueId;

  const SellerSettingsPage({
    super.key,
    required this.userId,
    required this.boutiqueId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SellerSettingsController()..fetchData(userId, boutiqueId),
      child: const _SellerSettingsView(),
    );
  }
}

class _SellerSettingsView extends StatelessWidget {
  const _SellerSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SellerSettingsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xFFEFEFEF),
        elevation: 0,
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.sellersettngs == null || controller.boutique == null
              ? const Center(child: Text("Failed to load data"))
              : RefreshIndicator(
                  onRefresh: () => controller.fetchData(
                    controller.sellersettngs!.id,
                    controller.boutique!.userId,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _profileCard(context, controller),
                      const SizedBox(height: 16),
                      _boutiqueCard(context, controller),
                    ],
                  ),
                ),
    );
  }

  Widget _profileCard(
      BuildContext context, SellerSettingsController controller) {
    final user = controller.sellersettngs!;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profile Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Username: ${user.username}'),
            const SizedBox(height: 8),
            Text('Email: ${user.email}'),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showProfileEditDialog(context, controller),
                child: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boutiqueCard(
      BuildContext context, SellerSettingsController controller) {
    final boutique = controller.boutique!;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Boutique Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Name: ${boutique.nom}'),
            const SizedBox(height: 8),
            Text('Description: ${boutique.description}'),
            const SizedBox(height: 8),
            Text('Address: ${boutique.address}'),
            const SizedBox(height: 8),
            Text('Contact: ${boutique.contact}'),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showBoutiqueEditDialog(context, controller),
                child: const Text('Edit Boutique'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileEditDialog(
      BuildContext context, SellerSettingsController controller) {
    final formKey = GlobalKey<FormState>();
    final usernameController =
        TextEditingController(text: controller.sellersettngs?.username);
    final emailController =
        TextEditingController(text: controller.sellersettngs?.email);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) =>
                    val!.isEmpty ? 'Username is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val!.isEmpty) return 'Email is required';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(val)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.updateUserProfile(SellerSettingsModel(
                  id: controller.sellersettngs!.id,
                  username: usernameController.text,
                  email: emailController.text,
                ));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Profile updated successfully')));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showBoutiqueEditDialog(
      BuildContext context, SellerSettingsController controller) {
    final formKey = GlobalKey<FormState>();
    final b = controller.boutique!;
    final nameController = TextEditingController(text: b.nom);
    final descController = TextEditingController(text: b.description);
    final addressController = TextEditingController(text: b.address);
    final contactController = TextEditingController(text: b.contact);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Boutique'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 2,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: contactController,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val!.isEmpty) return 'Required';
                    if (!RegExp(r'^\+?[\d\s-]{8,}$').hasMatch(val)) {
                      return 'Invalid number';
                    }
                    return null;
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
                final updated = Boutique(
                  nom: nameController.text,
                  userId: b.userId,
                  description: descController.text,
                  address: addressController.text,
                  contact: contactController.text,
                );
                controller.updateBoutique(updated);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Boutique updated successfully')));
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
