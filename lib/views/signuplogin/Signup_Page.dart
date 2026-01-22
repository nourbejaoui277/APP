import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app1/controllers/signup_controller.dart';
// Optional: Uncomment if you want Google Fonts
// import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupController _signupController = SignupController();
  bool _isLoading = false;
  bool _agreeToTerms = false;
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // AURA Branding
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  child: Text(
                    'AURA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // Optional: style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2196F3), // Blue for AURA
                    ),
                  ),
                ),
                // Form Container
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          // style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2F3861),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        controller: _signupController.usernameController,
                        hintText: "Username",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _signupController.emailController,
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _signupController.passwordController,
                        hintText: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _signupController.confirmPasswordController,
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      _buildRoleSelection(),
                      const SizedBox(height: 16),
                      _buildTermsAgreement(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading ||
                                !_agreeToTerms ||
                                _selectedRole == null
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await _signupController.signup(
                                    _signupController.usernameController.text,
                                    _signupController.emailController.text,
                                    _signupController.passwordController.text,
                                    _signupController
                                        .confirmPasswordController.text,
                                    _selectedRole!,
                                  );
                                  Fluttertoast.showToast(
                                    msg:
                                        "Sign up successful! Please verify your email.",
                                    backgroundColor: Colors.green,
                                  );
                                  Navigator.pop(context);
                                } catch (e) {
                                  Fluttertoast.showToast(
                                    msg: e.toString(),
                                    backgroundColor: Colors.red,
                                  );
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF2F3861),
                          elevation: 5,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                "Sign Up",
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFF2196F3)),
                      ),
                    ),
                  ],
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
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
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

  Widget _buildRoleSelection() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      hint: const Text("Select your role"),
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue;
        });
      },
      items: const [
        DropdownMenuItem(
          value: "customer",
          child: Text("Customer"),
        ),
        DropdownMenuItem(
          value: "seller",
          child: Text("Seller"),
        ),
      ],
      decoration: InputDecoration(
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
        prefixIcon: const Icon(Icons.account_circle, color: Color(0xFF2F3861)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select a role';
        }
        return null;
      },
    );
  }

  Widget _buildTermsAgreement() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: const Color(0xFF2196F3),
        ),
        Expanded(
          child: Text(
            "I agree to the terms of service and privacy policy",
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
