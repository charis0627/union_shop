import 'package:flutter/material.dart';
import 'package:union_shop/widgets/main_header.dart';
import 'package:union_shop/widgets/main_footer.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
  final String asset;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.asset,
    this.quantity = 1,
  });

  double get total {
    final priceValue = double.parse(price.replaceAll('£', ''));
    return priceValue * quantity;
  }
}

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void updateQuantity(String id, int quantity) {
    final item = _items.firstWhere((i) => i.id == id);
    if (quantity > 0) {
      item.quantity = quantity;
    } else {
      removeItem(id);
    }
  }

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  double get tax {
    return subtotal * 0.2; // 20% tax
  }

  double get total {
    return subtotal + tax;
  }

  void clearCart() {
    _items.clear();
  }

  int get itemCount => _items.length;
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainHeader(),
      body:
          _cartService.items.isEmpty ? _buildEmptyCart() : _buildCartContent(),
    );
  }

  Widget _buildEmptyCart() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Icon(Icons.shopping_bag_outlined,
                    size: 80, color: Colors.grey[300]),
                const SizedBox(height: 24),
                const Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Start shopping to add items to your cart',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const MainFooter(),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shopping Cart',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${_cartService.itemCount} items in cart',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final isWideScreen = width >= 900;

              if (isWideScreen) {
                return _buildDesktopLayout();
              } else {
                return _buildMobileLayout();
              }
            }),
          ),
          const SizedBox(height: 24),
          const MainFooter(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(0.8),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(0.8),
                  4: FlexColumnWidth(0.6),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Product',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Price',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(),
                      ),
                    ],
                  ),
                  ..._cartService.items.map((item) {
                    return TableRow(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(item.title),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(item.price),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _buildQuantityControl(item),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('£${item.total.toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red, size: 20),
                            onPressed: () {
                              setState(() {
                                _cartService.removeItem(item.id);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 1,
          child: _buildSummary(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        ...(_cartService.items.map((item) {
          return _buildCartItemCard(item);
        }).toList()),
        const SizedBox(height: 24),
        _buildSummary(),
      ],
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  item.asset,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(width: 80, height: 80, color: Colors.grey[300]),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(item.price,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    _buildQuantityControl(item),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: £${item.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _cartService.removeItem(item.id);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(CartItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 18),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            setState(() {
              _cartService.updateQuantity(item.id, item.quantity - 1);
            });
          },
        ),
        SizedBox(
          width: 40,
          child: TextField(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: item.quantity.toString()),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
            ),
            onChanged: (value) {
              final qty = int.tryParse(value);
              if (qty != null && qty > 0) {
                setState(() {
                  _cartService.updateQuantity(item.id, qty);
                });
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 18),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            setState(() {
              _cartService.updateQuantity(item.id, item.quantity + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSummaryRow(
              'Subtotal', '£${_cartService.subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildSummaryRow(
              'Tax (20%)', '£${_cartService.tax.toStringAsFixed(2)}'),
          Divider(color: Colors.grey[300], height: 24),
          _buildSummaryRow('Total', '£${_cartService.total.toStringAsFixed(2)}',
              isBold: true),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Continue Shopping',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  void _handleCheckout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Placed Successfully!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thank you for your purchase.'),
              const SizedBox(height: 16),
              _buildSummaryRow(
                  'Total Paid', '£${_cartService.total.toStringAsFixed(2)}',
                  isBold: true),
              const SizedBox(height: 8),
              Text('Items: ${_cartService.itemCount}',
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _cartService.clearCart();
                setState(() {});
                Navigator.pop(context); // Return to previous page
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
