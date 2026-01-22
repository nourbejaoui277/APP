import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'id': '1',
      'name': 'Classic Denim Jacket with a very long name that might overflow',
      'price': 99.99,
      'image': 'assets/images/denim jacket.png',
      'rating': 4.5,
    },
    {
      'id': '2',
      'name': 'Summer Floral Dress',
      'price': 79.99,
      'image': 'assets/images/floral dress.png',
      'rating': 4.0,
    },
    {
      'id': '3',
      'name': 'Leather Sneakers',
      'price': 129.99,
      'image': 'assets/images/leather.png',
      'rating': 4.8,
    },
  ];

  String _sortOption = 'Name';
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

  void _sortWishlistItems(String option) {
    setState(() {
      _sortOption = option;
      if (option == 'Price (Low to High)') {
        _wishlistItems.sort((a, b) => a['price'].compareTo(b['price']));
      } else if (option == 'Price (High to Low)') {
        _wishlistItems.sort((a, b) => b['price'].compareTo(a['price']));
      } else {
        _wishlistItems.sort((a, b) => a['name'].compareTo(b['name']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: FadeTransition(
        //   opacity: _fadeAnimation,
        //   child: const Text(
        //     'Wishlist',
        //     style: TextStyle(
        //       fontSize: 30,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //       shadows: [
        //         Shadow(
        //           color: Colors.black26,
        //           offset: Offset(1, 1),
        //           blurRadius: 4,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            iconSize: 28,
            icon: const Icon(Icons.sort, color: Colors.white, size: 28),
            onSelected: _sortWishlistItems,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'Price (Low to High)',
                child: Text('Price: Low to High'),
              ),
              const PopupMenuItem(
                value: 'Price (High to Low)',
                child: Text('Price: High to Low'),
              ),
            ],
          ),
        ],
      ),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: _wishlistItems.isEmpty
              ? _buildEmptyWishlist()
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _wishlistItems.length,
                  itemBuilder: (context, index) {
                    return _buildWishlistItem(_wishlistItems[index], index);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add some items you love!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/discover');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Browse Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400 + index * 200),
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            _navigateToProductDetails(item['id']);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container with fixed size
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item['image'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Content column with flexible width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16, // Reduced font size
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F3861),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\TND${item['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['rating'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      onPressed: () {
                        _removeFromWishlist(item['id'], item['name']);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Color(0xFF2196F3),
                        size: 24,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Add ${item['name']} to cart coming soon!'),
                          ),
                        );
                      },
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

  void _removeFromWishlist(String id, String name) {
    setState(() {
      _wishlistItems.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed from wishlist'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToProductDetails(String productId) {
    Navigator.pushNamed(
      context,
      '/product_details',
      arguments: productId,
    );
  }
}
