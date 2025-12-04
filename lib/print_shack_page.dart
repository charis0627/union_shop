// lib/print_shack_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/main_header.dart';
import 'package:union_shop/widgets/main_footer.dart';
import 'package:union_shop/cart_page.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  final List<String> perLineOptions = ['One Line of Text', 'Two Lines of Text'];
  String perLine = 'One Line of Text';

  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();

  final List<String> thumbnails = [
    'assets/images/hoodies.png',
    'assets/images/sweatshirts.png',
    'assets/images/hat.png',
    'assets/images/notebook.png',
  ];
  String selectedImage = 'assets/images/hoodies.png';

  final List<String> quantities = ['1', '2', '3', '4', '5'];
  String quantity = '1';

  static const int charLimitPerLine = 10;

  @override
  void dispose() {
    line1Controller.dispose();
    line2Controller.dispose();
    super.dispose();
  }

  bool get isValid {
    if (perLine == 'One Line of Text') {
      return line1Controller.text.trim().isNotEmpty &&
          line1Controller.text.length <= charLimitPerLine;
    } else {
      return line1Controller.text.trim().isNotEmpty &&
          line2Controller.text.trim().isNotEmpty &&
          line1Controller.text.length <= charLimitPerLine &&
          line2Controller.text.length <= charLimitPerLine;
    }
  }

  void _addToCart() {
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter valid personalization text.')),
      );
      return;
    }

    final cartService = CartService();
    final personalisationText = perLine == 'One Line of Text'
        ? line1Controller.text
        : '${line1Controller.text} / ${line2Controller.text}';

    final price = perLine == 'One Line of Text' ? '£3.00' : '£5.00';
    final qty = int.parse(quantity);

    cartService.addItem(
      CartItem(
        id: 'personalisation-$personalisationText-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Personalisation ($perLine)',
        price: price,
        asset: selectedImage,
        quantity: qty,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Added $quantity × Personalisation ($personalisationText) to cart'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CartPage(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreview(BoxConstraints constraints) {
    // Keep preview responsive to container size
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // background image (asset) with fallback
          Image.asset(
            selectedImage,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
          ),

          // dark overlay for readability
          Container(color: const Color(0x26000000)),

          // centered text preview
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (perLine == 'One Line of Text' ||
                    perLine == 'Two Lines of Text')
                  Text(
                    line1Controller.text.isEmpty
                        ? 'YOUR NAME HERE'
                        : line1Controller.text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontSize: constraints.maxWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                            blurRadius: 2,
                            color: Colors.black38,
                            offset: Offset(1, 1))
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (perLine == 'Two Lines of Text') const SizedBox(height: 8),
                if (perLine == 'Two Lines of Text')
                  Text(
                    line2Controller.text.isEmpty
                        ? ''
                        : line2Controller.text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontSize: constraints.maxWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                            blurRadius: 2,
                            color: Colors.black38,
                            offset: Offset(1, 1))
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(double width) {
    final isWide = width >= 900;
    final fieldWidth = isWide ? 360.0 : double.infinity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personalisation',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('£3.00',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text('Tax included.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),

        // Per line dropdown
        const Text('Per Line:'),
        const SizedBox(height: 6),
        SizedBox(
          width: fieldWidth,
          child: DropdownButtonFormField<String>(
            initialValue: perLine,
            items: perLineOptions
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) {
              setState(() {
                perLine = v!;
              });
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
            isDense: true,
          ),
        ),

        const SizedBox(height: 16),

        // text fields (one or two)
        const Text('Personalisation Line 1:'),
        const SizedBox(height: 6),
        SizedBox(
          width: fieldWidth,
          child: TextFormField(
            controller: line1Controller,
            maxLength: charLimitPerLine,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'One Line of Text'),
            onChanged: (_) => setState(() {}),
          ),
        ),

        if (perLine == 'Two Lines of Text') ...[
          const SizedBox(height: 12),
          const Text('Personalisation Line 2:'),
          const SizedBox(height: 6),
          SizedBox(
            width: fieldWidth,
            child: TextFormField(
              controller: line2Controller,
              maxLength: charLimitPerLine,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Second line of text'),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],

        const SizedBox(height: 16),
        const Text('Quantity'),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: DropdownButtonFormField<String>(
            initialValue: quantity,
            items: quantities
                .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                .toList(),
            onChanged: (v) => setState(() => quantity = v ?? '1'),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            isDense: true,
          ),
        ),

        const SizedBox(height: 20),

        // Add to cart button
        SizedBox(
          width: fieldWidth,
          child: OutlinedButton(
            onPressed: isValid ? _addToCart : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.deepPurple.shade700, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child:
                const Text('ADD TO CART', style: TextStyle(letterSpacing: 1.2)),
          ),
        ),

        const SizedBox(height: 12),
        Text('£3 for one line of text! £5 for two!',
            style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        const Text('One line of text is $charLimitPerLine characters.',
            style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainHeader(),
      body: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // main content
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: image & thumbnails
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 420,
                                child: _buildPreview(constraints),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 72,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: thumbnails.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (c, i) {
                                    final t = thumbnails[i];
                                    final selected = t == selectedImage;
                                    return GestureDetector(
                                      onTap: () =>
                                          setState(() => selectedImage = t),
                                      child: Container(
                                        width: 72,
                                        height: 72,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selected
                                                  ? Colors.deepPurple
                                                  : Colors.grey.shade300,
                                              width: selected ? 3 : 1),
                                        ),
                                        child: Image.asset(t,
                                            fit: BoxFit.cover,
                                            errorBuilder: (c, e, s) =>
                                                Container(
                                                    color: Colors.grey[300])),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Right: form
                        Expanded(
                            flex: 4, child: _buildForm(constraints.maxWidth)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        SizedBox(
                            height: 300, child: _buildPreview(constraints)),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 72,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: thumbnails.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (c, i) {
                              final t = thumbnails[i];
                              final selected = t == selectedImage;
                              return GestureDetector(
                                onTap: () => setState(() => selectedImage = t),
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selected
                                          ? Colors.deepPurple
                                          : Colors.grey.shade300,
                                      width: selected ? 3 : 1,
                                    ),
                                  ),
                                  child: Image.asset(
                                    t,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) =>
                                        Container(color: Colors.grey[300]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildForm(constraints.maxWidth),
                      ],
                    ),
              // Footer
              const SizedBox(height: 24),
              const MainFooter(),
            ],
          ),
        );
      }),
    );
  }
}
