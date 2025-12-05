import 'package:flutter/material.dart';
import 'package:union_shop/widgets/main_header.dart';
import 'package:union_shop/widgets/main_footer.dart';
import 'package:union_shop/models/products.dart';
import 'package:union_shop/product_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text('Collections',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 28),
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width >= 600 ? 3 : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.0,
                ),
                itemCount: ProductDatabase.categories.length,
                itemBuilder: (context, index) {
                  final category = ProductDatabase.categories[index];
                  return _CollectionCard(
                    key: Key('collection_card_$index'),
                    title: category.name,
                    asset: category.imageAsset,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CollectionDetailPage(
                          title: category.name,
                          asset: category.imageAsset,
                        ),
                      ));
                    },
                  );
                },
              );
            }),
            const SizedBox(height: 24),
            const MainFooter(),
          ],
        ),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final String title;
  final String asset;
  final VoidCallback onTap;

  const _CollectionCard(
      {super.key,
      required this.title,
      required this.asset,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(asset,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: Colors.grey[300])),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0x73000000),
                ],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionDetailPage extends StatefulWidget {
  final String title;
  final String asset;

  const CollectionDetailPage(
      {super.key, required this.title, required this.asset});

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  String _selectedCategory = 'All products';
  String _selectedSort = 'Best selling';
  int _currentPage = 1;
  final int _itemsPerPage = 9;

  List<Product> get _allProducts {
    return ProductDatabase.getProductsByCategory(widget.title);
  }

  List<Product> get _filteredAndSortedProducts {
    var products = _allProducts;

    // Apply category filter
    if (_selectedCategory != 'All products') {
      products = products
          .where((p) => p.category
              .toLowerCase()
              .contains(_selectedCategory.toLowerCase()))
          .toList();
    }

    // Apply sorting
    switch (_selectedSort) {
      case 'Price: Low to High':
        products.sort(
            (a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
        break;
      case 'Price: High to Low':
        products.sort(
            (a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
        break;
      case 'Alphabetically':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Newest':
        products = products.reversed.toList();
        break;
      case 'Best selling':
      default:
        // Keep original order
        break;
    }

    return products;
  }

  double _parsePrice(String price) {
    return double.tryParse(price.replaceAll('£', '').replaceAll(',', '')) ??
        0.0;
  }

  List<Product> get _paginatedProducts {
    final filtered = _filteredAndSortedProducts;
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    if (startIndex >= filtered.length) return [];
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  int get _totalPages {
    final total = _filteredAndSortedProducts.length;
    return (total / _itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final products = _paginatedProducts;
    final totalProductCount = _filteredAndSortedProducts.length;

    return Scaffold(
      appBar: const MainHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Shop all of this collection below.'),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Row(
                children: [
                  const Text('Filter By',
                      style: TextStyle(letterSpacing: 1.2, color: Colors.grey)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedCategory,
                      items: const [
                        DropdownMenuItem(
                            value: 'All products', child: Text('All products')),
                        DropdownMenuItem(
                            value: 'Hoodies', child: Text('Hoodies')),
                        DropdownMenuItem(
                            value: 'Sweatshirts', child: Text('Sweatshirts')),
                        DropdownMenuItem(
                            value: 'Notebooks', child: Text('Notebooks')),
                        DropdownMenuItem(
                            value: 'Notepads', child: Text('Notepads')),
                        DropdownMenuItem(value: 'Hats', child: Text('Hats')),
                        DropdownMenuItem(value: 'Cups', child: Text('Cups')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                            _currentPage = 1; // Reset to first page
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Sort By',
                      style: TextStyle(letterSpacing: 1.2, color: Colors.grey)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedSort,
                      items: const [
                        DropdownMenuItem(
                            value: 'Best selling', child: Text('Best selling')),
                        DropdownMenuItem(
                            value: 'Price: Low to High',
                            child: Text('Price: Low to High')),
                        DropdownMenuItem(
                            value: 'Price: High to Low',
                            child: Text('Price: High to Low')),
                        DropdownMenuItem(
                            value: 'Newest', child: Text('Newest')),
                        DropdownMenuItem(
                            value: 'Alphabetically',
                            child: Text('Alphabetically')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedSort = value;
                            _currentPage = 1; // Reset to first page
                          });
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  Text('$totalProductCount products',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount =
                    width >= 900 ? 3 : (width >= 600 ? 2 : 1);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _CollectionItemCard(
                      title: product.title,
                      price: product.price,
                      asset: product.imageAsset,
                    );
                  },
                );
              }),
            ),
            // Pagination controls
            if (_totalPages > 1)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 1
                          ? () {
                              setState(() {
                                _currentPage--;
                              });
                            }
                          : null,
                    ),
                    const SizedBox(width: 12),
                    for (int i = 1; i <= _totalPages; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _currentPage == i
                            ? Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '$i',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPage = i;
                                  });
                                },
                                child: Text(
                                  '$i',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                      ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _currentPage < _totalPages
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            const MainFooter(),
          ],
        ),
      ),
    );
  }
}

class _CollectionItemCard extends StatelessWidget {
  final String title;
  final String price;
  final String asset;

  const _CollectionItemCard(
      {required this.title, required this.price, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductPage(
              title: title,
              price: price,
              asset: asset,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(asset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (c, e, s) =>
                      Container(color: Colors.grey[300])),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(price, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
