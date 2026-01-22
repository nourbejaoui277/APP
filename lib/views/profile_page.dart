import 'package:flutter/material.dart';
import 'cart_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  // TODO: Fetch from POST /api/User/GetUserProfile/GetUserProfile
  final Map<String, dynamic> _profileData = {
    'name': 'amira saada',
    'email': 'amirasaada100@gmail.com',
    'phone': '+216 55 369 777',
    'wishlistCount': 5, // Placeholder for GET /api/UserWishlist/me
    'wishlistPreview': {
      'name': 'floral dress',
      'image': 'assets/images/floral dress.png',
    },
  };
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: FadeTransition(
      //     opacity: _fadeAnimation,
      //     child: const Text(
      //       'Profile',
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         shadows: [
      //           Shadow(
      //             color: Colors.black26,
      //             offset: Offset(1, 1),
      //             blurRadius: 4,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              _buildProfileHeader(),
              const SizedBox(height: 32),
              _buildWishlistSummary(),
              const SizedBox(height: 32),
              _buildCartSummary(),
              const SizedBox(height: 32),
              _buildSettingsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: const Color(0xFF2196F3).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    const AssetImage('assets/images/profile_pic.png'),
                backgroundColor: Colors.grey[200],
                onBackgroundImageError: (_, __) => Image.asset(
                  'assets/images/placeholder.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Edit profile picture coming soon!')),
                    );
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2196F3),
                    child:
                        const Icon(Icons.edit, size: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profileData['name'],
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3861),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _profileData['email'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  _profileData['phone'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistSummary() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset(
              'assets/images/wishlist_icon.png',
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.favorite,
                color: Color(0xFF2196F3),
                size: 40,
              ),
            ),
            title: const Text(
              'Your Wishlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3861),
              ),
            ),
            subtitle: Text(
              '${_profileData['wishlistCount']} items saved',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          const Divider(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    _profileData['wishlistPreview']['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Preview: ${_profileData['wishlistPreview']['name']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2F3861),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wishlist').catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Wishlist page not set up yet!')),
                  );
                });
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: CartState.cartCount,
        builder: (context, cartCount, child) {
          return ListTile(
            leading: Image.asset(
              'assets/images/cart_icon.png',
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.shopping_cart,
                color: Color(0xFF2196F3),
                size: 40,
              ),
            ),
            title: const Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3861),
              ),
            ),
            subtitle: Text(
              '$cartCount items in cart',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: Color(0xFF2196F3)),
            onTap: () {
              Navigator.pushNamed(context, '/cart').catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart page not set up yet!')),
                );
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildSettingsList() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Profile & Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3861),
              ),
            ),
          ),
          _buildSettingsTile(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              Navigator.pushNamed(context, '/edit_profile').catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Edit profile page not set up yet!')),
                );
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              Navigator.pushNamed(context, '/change_password').catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Change password page not set up yet!')),
                );
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.history,
            title: 'Order History',
            onTap: () {
              Navigator.pushNamed(context, '/order_history').catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Order history page not set up yet!')),
                );
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3861),
              ),
            ),
          ),
          _buildSettingsTile(
            icon: Icons.logout,
            title: 'Log Out',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Log Out'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(color: Color(0xFF2196F3))),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false)
                            .catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Login page not set up yet!')),
                          );
                        });
                      },
                      child: const Text('Log Out',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2F3861), size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2F3861),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            )
          : null,
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios,
              size: 16, color: Color(0xFF2196F3)),
      onTap: onTap,
    );
  }
}
