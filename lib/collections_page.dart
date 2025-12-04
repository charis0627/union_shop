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

class CollectionDetailPage extends StatelessWidget {
  final String title;
  final String asset;

  const CollectionDetailPage(
      {super.key, required this.title, required this.asset});

  List<Product> get items {
    return ProductDatabase.getProductsByCategory(title);
  }

  @override
  Widget build(BuildContext context) {
    final products = items;

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
                  Text(title,
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
                      value: 'All products',
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
                      onChanged: (_) {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Sort By',
                      style: TextStyle(letterSpacing: 1.2, color: Colors.grey)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Best selling',
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
                      onChanged: (_) {},
                    ),
                  ),
                  const Spacer(),
                  const Text('10 products',
                      style: TextStyle(color: Colors.black54)),
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
