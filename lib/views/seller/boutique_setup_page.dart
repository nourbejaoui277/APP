import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app1/services/boutique_service.dart';
import 'package:app1/services/auth_service.dart';
import 'package:app1/views/seller/seller_home_page.dart';

class BoutiqueSetupPage extends StatefulWidget {
  const BoutiqueSetupPage({super.key});

  @override
  _BoutiqueSetupPageState createState() => _BoutiqueSetupPageState();
}

class _BoutiqueSetupPageState extends State<BoutiqueSetupPage> {
  final BoutiqueService _boutiqueService = BoutiqueService();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _createBoutique() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final userId = await _authService.getCurrentUserId();
      await _boutiqueService.createBoutique(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        address: _addressController.text.trim(),
        contact: _contactController.text.trim(),
        userId: userId,
      );

      // Update role to regular seller
      await _authService.saveUserRole('seller');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SellerHomePage()),
        (route) => false,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to create boutique: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Up Your Boutique"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Create Your Boutique",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3861),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Fill in the details to set up your boutique.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  hintText: "Boutique Name",
                  icon: Icons.store,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter boutique name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  icon: Icons.description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    if (value.length < 20) {
                      return 'Description should be at least 20 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _addressController,
                  hintText: "Address",
                  icon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _contactController,
                  hintText: "Contact Info (e.g., phone, email)",
                  icon: Icons.contact_phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createBoutique,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F3861),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Create Boutique",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2196F3)),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(icon, color: const Color(0xFF2F3861)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
