import 'package:flutter/material.dart';
import 'package:union_shop/widgets/main_header.dart';
import 'package:union_shop/widgets/main_footer.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final String price;
  final String asset;

  const ProductPage({
    super.key,
    this.title = 'Product name',
    this.price = '£15.00',
    this.asset =
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedColor = 'Black';
  String _selectedSize = 'S';
  String _selectedQuantity = '1';

  void _showPlaceholder(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product details
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: LayoutBuilder(builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;

                Widget imageColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main image
                    Container(
                      height: isWide ? 420 : 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.asset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Image unavailable',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Thumbnails
                    SizedBox(
                      height: 72,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < 4; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  widget.asset,
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    width: 72,
                                    height: 72,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );

                Widget infoColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: const TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(widget.price,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 8),
                    const Text('Tax included.',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),

                    // Options row
                    Wrap(
                      runSpacing: 12,
                      spacing: 24,
                      children: [
                        SizedBox(
                          width: isWide ? 240 : 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Color',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    iconSize: 20,
                                    value: _selectedColor,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'Black', child: Text('Black')),
                                      DropdownMenuItem(
                                          value: 'Green', child: Text('Green')),
                                      DropdownMenuItem(
                                          value: 'Purple',
                                          child: Text('Purple')),
                                      DropdownMenuItem(
                                          value: 'Grey', child: Text('Grey')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _selectedColor = v);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: isWide ? 180 : 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Size',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    iconSize: 20,
                                    value: _selectedSize,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'S', child: Text('S')),
                                      DropdownMenuItem(
                                          value: 'M', child: Text('M')),
                                      DropdownMenuItem(
                                          value: 'L', child: Text('L')),
                                      DropdownMenuItem(
                                          value: 'XL', child: Text('XL')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _selectedSize = v);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: isWide ? 90 : 64,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Quantity',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    iconSize: 20,
                                    value: _selectedQuantity,
                                    items: const [
                                      DropdownMenuItem(
                                          value: '1', child: Text('1')),
                                      DropdownMenuItem(
                                          value: '2', child: Text('2')),
                                      DropdownMenuItem(
                                          value: '3', child: Text('3')),
                                      DropdownMenuItem(
                                          value: '4', child: Text('4')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() => _selectedQuantity = v);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: isWide ? 380 : double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _showPlaceholder(
                            'Added $_selectedQuantity x Classic Sweatshirt ($_selectedColor, $_selectedSize) to cart'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF4d2963)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('ADD TO CART',
                            style: TextStyle(letterSpacing: 1.2)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: isWide ? 380 : double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showPlaceholder('Buy with shop (placeholder)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5a31ff),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Buy with shop',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text('More payment options',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black54)),
                    const SizedBox(height: 24),

                    const Text('Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text(
                      'Bringing to you, our best selling Classic Sweatshirt. Available in 4 different colours.',
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey, height: 1.5),
                    ),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: imageColumn),
                      const SizedBox(width: 40),
                      Expanded(flex: 4, child: infoColumn),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imageColumn,
                    const SizedBox(height: 24),
                    infoColumn
                  ],
                );
              }),
            ),

            // Footer
            const MainFooter(),
          ],
        ),
      ),
    );
  }
}
