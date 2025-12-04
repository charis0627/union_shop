import 'package:flutter/material.dart';
import 'package:union_shop/cart_page.dart';

class MainHeader extends StatelessWidget implements PreferredSizeWidget {
  const MainHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE!COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false),
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        final isMobile = screenWidth < 600;

                        if (isMobile) {
                          // Mobile view: show spacer and only icon buttons
                          return Row(
                            children: [
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.person_outline,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/auth');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const CartPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.menu,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    onSelected: (value) {
                                      switch (value) {
                                        case 'home':
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, '/', (route) => false);
                                          break;
                                        case 'sale':
                                          Navigator.pushNamed(context, '/sale');
                                          break;
                                        case 'about':
                                          Navigator.pushNamed(
                                              context, '/about');
                                          break;
                                        case 'collections':
                                          Navigator.pushNamed(
                                              context, '/collections');
                                          break;
                                        case 'print_about':
                                          Navigator.pushNamed(
                                              context, '/about-print-shack');
                                          break;
                                        case 'print_personalisation':
                                          Navigator.pushNamed(
                                              context, '/print-shack');
                                          break;
                                      }
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(
                                          value: 'home', child: Text('Home')),
                                      PopupMenuItem(
                                          value: 'sale', child: Text('SALE!')),
                                      PopupMenuItem(
                                          value: 'about', child: Text('About')),
                                      PopupMenuItem(
                                          value: 'collections',
                                          child: Text('Collections')),
                                      PopupMenuItem(
                                          value: 'print_about',
                                          child:
                                              Text('The Print Shack — About')),
                                      PopupMenuItem(
                                          value: 'print_personalisation',
                                          child: Text(
                                              'The Print Shack — Personalisation')),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        }

                        // Desktop view: show navigation buttons and icons
                        return Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pushNamedAndRemoveUntil(
                                                context, '/', (route) => false),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          foregroundColor: Colors.black,
                                        ),
                                        child: const Text('Home'),
                                      ),
                                      const SizedBox(width: 8),
                                      PopupMenuButton<String>(
                                        padding: EdgeInsets.zero,
                                        onSelected: (value) {
                                          if (value == 'about') {
                                            Navigator.pushNamed(
                                                context, '/about-print-shack');
                                          } else if (value ==
                                              'personalisation') {
                                            Navigator.pushNamed(
                                                context, '/print-shack');
                                          }
                                        },
                                        itemBuilder: (_) => const [
                                          PopupMenuItem(
                                              value: 'about',
                                              child: Text('About')),
                                          PopupMenuItem(
                                              value: 'personalisation',
                                              child: Text('Personalisation')),
                                        ],
                                        child: const Row(
                                          children: [
                                            Text(
                                              'The Print Shack',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 1.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Icon(Icons.arrow_drop_down,
                                                size: 18, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/sale'),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          foregroundColor: Colors.black,
                                        ),
                                        child: const Text('SALE!'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/about'),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          foregroundColor: Colors.black,
                                        ),
                                        child: const Text('About'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/collections'),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          foregroundColor: Colors.black,
                                        ),
                                        child: const Text('Collections'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      size: 18, color: Colors.grey),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.person_outline,
                                      size: 18, color: Colors.black),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/auth');
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.shopping_bag_outlined,
                                      size: 18, color: Colors.black),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const CartPage(),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      size: 18, color: Colors.black),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
