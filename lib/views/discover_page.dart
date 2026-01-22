import 'package:app1/models/order_model.dart';
import 'package:app1/models/product_details_model.dart';
import 'package:app1/models/search_filter.dart';
import 'package:app1/services/product_service.dart';
import 'package:app1/views/product_details_Page.dart';
import 'package:app1/views/search_result_page.dart';
import 'package:flutter/material.dart';
import 'men_page.dart';
import 'women_page.dart';
import 'kids_page.dart';
import 'cart_state.dart';
import 'package:app1/models/order_model.dart' as prod;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Backend category data
  final Map<String, List<String>> categories = {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              setState(() {
                _isSearchFocused = true;
              });
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                _buildSectionTitle('Categories'),
                _buildCategories(),
                const SizedBox(height: 32),
                _buildSectionTitle('New Arrivals'),
                _buildNewArrivals(),
                const SizedBox(height: 32),
              ],
            ),
          ),
          if (_isSearchFocused)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSearchFocused = false;
                    _searchController.clear();
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
                onSubmitted: (value) {
                  setState(() {
                    _isSearchFocused = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Searching for: $value')),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search by name, category...',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF2F3861)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon:
                              const Icon(Icons.clear, color: Color(0xFF2F3861)),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.transparent,
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
                          builder: (context) =>
                              FilterPanel(categories: categories),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F3861),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('See all $title coming soon!')),
              );
            },
            child: const Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final List<Map<String, String>> categories = [
      {'title': 'Men', 'image': 'assets/images/men.jpg'},
      {'title': 'Women', 'image': 'assets/images/women.jpg'},
      {'title': 'Kids', 'image': 'assets/images/kids.png'},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == categories.length - 1 ? 0 : 16,
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400 + index * 200),
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(categories[index]['image']!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    String category = categories[index]['title']!;
                    Widget page;

                    switch (category) {
                      case 'Men':
                        page = MenPage();
                        break;
                      case 'Women':
                        page = WomenPage();
                        break;
                      case 'Kids':
                        page = KidsPage();
                        break;
                      default:
                        return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        categories[index]['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewArrivals() {
    final List<Map<String, dynamic>> arrivals = [
      {
        'name': 'Palestine Tote bag',
        'price': '\TND 89.99',
        'rating': 4.5,
        'image': 'assets/images/arrival1.png'
      },
      {
        'name': 'Men T-shirt',
        'price': '\TND 109.99',
        'rating': 4.0,
        'image': 'assets/images/arrival2.png'
      },
      {
        'name': 'dress little girl',
        'price': '\TND 69.99',
        'rating': 4.8,
        'image': 'assets/images/arrival3.png'
      },
    ];

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arrivals.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == arrivals.length - 1 ? 0 : 16,
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400 + index * 200),
              width: 180,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsPage(
                          productDetails: Productdetails(
                            id: index.toString(),
                            name: arrivals[index]['name'],
                            price: double.parse(arrivals[index]['price']
                                .replaceAll(RegExp(r'[^\d.]'), '')),
                            imageUrl: arrivals[index]['image'],
                            description:
                                'This is a sample description for ${arrivals[index]['name']}',
                            rating: arrivals[index]['rating'],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage(arrivals[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                arrivals[index]['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                arrivals[index]['price']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    arrivals[index]['rating'].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Color(0xFF2196F3),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Add to wishlist: ${arrivals[index]['name']}')),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Color(0xFF2196F3),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      final item = CartItem(
                                        name: arrivals[index]['name']!,
                                        price: arrivals[index]['price']!,
                                        image: arrivals[index]['image']!,
                                      );
                                      CartState.addToCart(item);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '${arrivals[index]['name']} added to cart!')),
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
        },
      ),
    );
  }
}

class FilterPanel extends StatefulWidget {
  final Map<String, List<String>> categories;

  const FilterPanel({Key? key, required this.categories}) : super(key: key);

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? _selectedMainCategory;
  final Map<String, bool> _selectedSubCategories = {};
  RangeValues _priceRange = const RangeValues(0, 200);

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
              mainAxisSize: MainAxisSize.min,
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
                  'Filter by Category and Price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3861),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Main Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.categories.keys.map((mainCategory) {
                    return ChoiceChip(
                      label: Text(mainCategory),
                      selected: _selectedMainCategory == mainCategory,
                      onSelected: (selected) {
                        setState(() {
                          _selectedMainCategory =
                              selected ? mainCategory : null;
                          _selectedSubCategories.clear();
                        });
                      },
                      selectedColor: const Color(0xFF2196F3),
                      labelStyle: TextStyle(
                        color: _selectedMainCategory == mainCategory
                            ? Colors.white
                            : const Color(0xFF2F3861),
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedMainCategory != null) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Subcategories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.categories[_selectedMainCategory]!
                        .map((subCategory) {
                      return FilterChip(
                        label: Text(subCategory),
                        selected: _selectedSubCategories[subCategory] ?? false,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSubCategories[subCategory] = selected;
                          });
                        },
                        selectedColor: const Color(0xFF2196F3),
                        labelStyle: TextStyle(
                          color: _selectedSubCategories[subCategory] ?? false
                              ? Colors.white
                              : const Color(0xFF2F3861),
                        ),
                      );
                    }).toList(),
                  ),
                ],
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
                  divisions: 20, // Increments of 10 TND
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedMainCategory = null;
                          _selectedSubCategories.clear();
                          _priceRange = const RangeValues(0, 200);
                        });
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Color(0xFF2F3861)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        // final selectedFilters = {
                        //   'mainCategory': _selectedMainCategory,
                        //   'subCategories': _selectedSubCategories.entries
                        //       .where((entry) => entry.value)
                        //       .map((entry) => entry.key)
                        //       .toList(),
                        //   'priceRange': {
                        //     'min': _priceRange.start,
                        //     'max': _priceRange.end,
                        //   },
                        // };
                        // Navigator.pop(context);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Applied filters: $selectedFilters'),
                        //   ),
                        // );
                        final filters = SearchFilters(
                          boutiqueId: null,
                          categoryId: _selectedMainCategory != null
                              ? int.parse((_selectedMainCategory == "Men"
                                  ? 1.toString()
                                  : _selectedMainCategory == "Women"
                                      ? 2.toString()
                                      : _selectedMainCategory == "Kids"
                                          ? 3.toString()
                                          : null)!)
                              : null,
                          sectionId: _selectedSubCategories.entries
                              .where((e) => e.value)
                              .map((e) => int.tryParse(e.key)!)
                              .toList(),
                          minPrice: _priceRange.start,
                          maxPrice: _priceRange.end,
                          searchWord: "",
                        );
                        List<prod.Product> res =
                            (await ProductService().searchProduct(filters))
                                .cast<Product>();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchResultsPage(results: res),
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
