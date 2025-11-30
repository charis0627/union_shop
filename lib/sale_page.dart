import 'package:flutter/material.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  static const List<Map<String, String>> products = [
    {
      'title': 'Classic Sweatshirt',
      'old': '£17.00',
      'price': '£10.99',
      'asset': 'assets/images/sweatshirts.png'
    },
    {
      'title': 'A5 Notepad',
      'old': '£3.50',
      'price': '£1.80',
      'asset': 'assets/images/notepad.png'
    },
    {
      'title': 'Notebook',
      'old': '£3.00',
      'price': '£1.80',
      'asset': 'assets/images/notebook.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('SALE', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
            child: Column(
              children: [
                Text('SALE',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Don't miss out! Get yours before they're all gone!",
                    style: TextStyle(color: Colors.black)),
                SizedBox(height: 12),
                Text('All prices shown are inclusive of the discount',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: Row(
              children: [
                const Text('Filter By',
                    style: TextStyle(letterSpacing: 1.2, color: Colors.grey)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: 'All products',
                  items: const [
                    DropdownMenuItem(
                        value: 'All products', child: Text('All products')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(width: 28),
                const Text('Sort By',
                    style:
                        TextStyle(letterSpacing: 1.2, color: Colors.black54)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: 'Best selling',
                  items: const [
                    DropdownMenuItem(
                        value: 'Best selling', child: Text('Best selling')),
                  ],
                  onChanged: (_) {},
                ),
                const Spacer(),
                const Text('3 products', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount =
                    width >= 900 ? 3 : (width >= 600 ? 2 : 1);

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.15,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return SaleProductCard(
                      key: Key('sale_card_$index'),
                      title: p['title']!,
                      oldPrice: p['old']!,
                      price: p['price']!,
                      asset: p['asset']!,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SaleProductCard extends StatelessWidget {
  final String title;
  final String oldPrice;
  final String price;
  final String asset;

  const SaleProductCard(
      {super.key,
      required this.title,
      required this.oldPrice,
      required this.price,
      required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$title (dummy)'))),
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
          Row(
            children: [
              Text(oldPrice,
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.black)),
              const SizedBox(width: 8),
              Text(price,
                  style: const TextStyle(
                      color: Color(0xFF2d2963), fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
