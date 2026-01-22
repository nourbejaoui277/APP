import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/controllers/product_controller.dart';
import 'package:app1/models/product_model.dart';
import 'cart_state.dart';

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  State<WomenPage> createState() => _WomenPageState();
}

class _WomenPageState extends State<WomenPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String? _activeSubcategory;
  String? _selectedSubcategory;
  RangeValues _priceRange = const RangeValues(0, 200);
  int? _selectedBoutiqueId;
  String _searchQuery = '';

  static final Map<String, int> _subcategories = {
    "Dresses": 1,
    "Tops": 2,
    "Bottoms": 3,
    "Outerwear": 4,
    "Activewear": 5,
    "Footwear": 6,
    "Accessories": 7,
    "Bags": 8,
    "Swimwear": 9,
    "Sleepwear": 10,
    "Traditional/Cultural Wear": 11,
  };

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
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProductController()..loadProducts()),
        //ChangeNotifierProvider(create: (_) => CartState()),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Women’s Fashion',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 28),
              onPressed: () {
                setState(() {
                  _isSearchFocused = true;
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart,
                  color: Colors.white, size: 28),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart page coming soon!')),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
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
            ),
            Consumer<ProductController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2196F3)),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 20, right: 20),
                      sliver: SliverToBoxAdapter(
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildSubcategoryTabs(),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final subcategory =
                              _subcategories.keys.toList()[index];
                          final subcategoryId = _subcategories[subcategory]!;
                          final products = controller
                              .filterProducts(
                                sectionId: 2,
                                subcategory: _selectedSubcategory,
                                priceRange: _priceRange,
                                boutiqueId: _selectedBoutiqueId,
                                searchQuery: _searchQuery,
                                subcategories: _subcategories,
                              )
                              .where((p) => p.categoryId == subcategoryId)
                              .toList();
                          if (products.isEmpty &&
                              _selectedSubcategory != null) {
                            return const SizedBox.shrink();
                          }
                          return _buildSubcategorySection(
                              subcategory, subcategoryId, products);
                        },
                        childCount: _subcategories.length,
                      ),
                    ),
                  ],
                );
              },
            ),
            if (_isSearchFocused)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearchFocused = false;
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: _buildSearchOverlay(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubcategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = _subcategories.keys.toList()[index];
          final isActive = _activeSubcategory == subcategory;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeSubcategory = subcategory;
                  _selectedSubcategory = subcategory;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF2196F3) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  subcategory,
                  style: TextStyle(
                    color: isActive ? Colors.white : const Color(0xFF2F3861),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubcategorySection(
      String subcategory, int subcategoryId, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subcategory,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3861),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: products.isEmpty
                ? _buildSampleProducts(subcategoryId)
                : _buildProducts(products),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchOverlay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Women’s products...',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF2F3861)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon:
                              const Icon(Icons.clear, color: Color(0xFF2F3861)),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFF2196F3), width: 2),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.filter_list,
                          color: Color(0xFF2F3861)),
                      label: const Text(
                        'Filter',
                        style: TextStyle(color: Color(0xFF2F3861)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => FilterPanel(
                            subcategories: _subcategories,
                            initialSubcategory: _selectedSubcategory,
                            initialPriceRange: _priceRange,
                            initialBoutiqueId: _selectedBoutiqueId,
                            onApply: (subcategory, priceRange, boutiqueId) {
                              setState(() {
                                _selectedSubcategory = subcategory;
                                _priceRange = priceRange;
                                _selectedBoutiqueId = boutiqueId;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProducts(List<Product> products) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildSampleProducts(int subcategoryId) {
    if (subcategoryId < 1 || subcategoryId > _subcategories.length) {
      return const SizedBox.shrink();
    }
    final subcategoryName = _subcategories.keys.toList()[subcategoryId - 1];
    final sampleProducts = [
      Product(
        id: 'w_${subcategoryId}_1',
        name: 'Women’s $subcategoryName Item 1',
        price: 59.99 + subcategoryId * 10,
        stock: 18,
        sectionId: 2,
        categoryId: subcategoryId,
        boutiqueId: subcategoryId % 3 + 1,
        description: 'Elegant $subcategoryName',
      ),
      Product(
        id: 'w_${subcategoryId}_2',
        name: 'Women’s $subcategoryName Item 2',
        price: 69.99 + subcategoryId * 10,
        stock: 12,
        sectionId: 2,
        categoryId: subcategoryId,
        boutiqueId: subcategoryId % 3 + 1,
        description: 'Casual $subcategoryName',
      ),
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: sampleProducts.length,
      itemBuilder: (context, index) {
        return _buildProductCard(sampleProducts[index]);
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        height: 250, // Fixed height to control overflow
        width: 180,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} clicked!')),
              );
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bestseller1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'TND ${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Color(0xFF2196F3),
                                size: 20,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Added ${product.name} to wishlist')),
                                );
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                color: Color(0xFF2196F3),
                                size: 20,
                              ),
                              onPressed: () {
                                final cartItem = CartItem(
                                  name: product.name,
                                  price:
                                      'TND ${product.price.toStringAsFixed(2)}',
                                  image: 'assets/images/women_default.jpg',
                                );
                                CartState.addToCart(cartItem);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${product.name} added to cart!')),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterPanel extends StatefulWidget {
  final Map<String, int> subcategories;
  final String? initialSubcategory;
  final RangeValues initialPriceRange;
  final int? initialBoutiqueId;
  final void Function(String?, RangeValues, int?) onApply;

  const FilterPanel({
    super.key,
    required this.subcategories,
    this.initialSubcategory,
    required this.initialPriceRange,
    this.initialBoutiqueId,
    required this.onApply,
  });

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? _selectedSubcategory;
  RangeValues _priceRange = const RangeValues(0, 200);
  int? _selectedBoutiqueId;

  static final Map<int, String> _boutiques = {
    1: 'Boutique A',
    2: 'Boutique B',
    3: 'Boutique C',
  };

  @override
  void initState() {
    super.initState();
    _selectedSubcategory = widget.initialSubcategory;
    _priceRange = widget.initialPriceRange;
    _selectedBoutiqueId = widget.initialBoutiqueId;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const Text(
                  'Filter Women’s Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3861),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Subcategory',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedSubcategory,
                  decoration: const InputDecoration(
                    labelText: 'Subcategory',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('All'),
                    ),
                    ...widget.subcategories.keys
                        .map((subcategory) => DropdownMenuItem(
                              value: subcategory,
                              child: Text(subcategory),
                            ))
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedSubcategory = value;
                    });
                  },
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Price Range (TND)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TND ${_priceRange.start.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF2F3861),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'TND ${_priceRange.end.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF2F3861),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 200,
                  divisions: 20,
                  activeColor: const Color(0xFF2196F3),
                  inactiveColor: Colors.grey[300],
                  labels: RangeLabels(
                    _priceRange.start.toStringAsFixed(0),
                    _priceRange.end.toStringAsFixed(0),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Boutique',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: _selectedBoutiqueId,
                  decoration: const InputDecoration(
                    labelText: 'Boutique',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<int>(
                      value: null,
                      child: Text('All'),
                    ),
                    ..._boutiques.entries.map((entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ))
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedBoutiqueId = value;
                    });
                  },
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedSubcategory = null;
                          _priceRange = const RangeValues(0, 200);
                          _selectedBoutiqueId = null;
                        });
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Color(0xFF2F3861)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        widget.onApply(
                          _selectedSubcategory,
                          _priceRange,
                          _selectedBoutiqueId,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Filters applied: '
                                'Subcategory: ${_selectedSubcategory ?? "All"}, '
                                'Price: TND ${_priceRange.start.toStringAsFixed(0)}–${_priceRange.end.toStringAsFixed(0)}, '
                                'Boutique: ${_boutiques[_selectedBoutiqueId] ?? "All"}'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
