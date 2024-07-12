import 'package:flutter/material.dart';

class EditProfileController {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  EditProfileController({
    required String initialName,
    required String initialEmail,
    required String initialPhone,
  })  : nameController = TextEditingController(text: initialName),
        emailController = TextEditingController(text: initialEmail),
        phoneController = TextEditingController(text: initialPhone);

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  void saveProfile() {
    String updatedName = nameController.text;
    String updatedEmail = emailController.text;
    String updatedPhone = phoneController.text;
  }
}
