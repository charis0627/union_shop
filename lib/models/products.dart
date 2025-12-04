class Product {
  final String id;
  final String title;
  final String price;
  final String category;
  final String imageAsset;
  final String? description;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.imageAsset,
    this.description,
  });

  double get priceValue {
    return double.tryParse(price.replaceAll('£', '')) ?? 0.0;
  }
}

/// Collection category model
class ProductCategory {
  final String name;
  final String imageAsset;

  const ProductCategory({
    required this.name,
    required this.imageAsset,
  });
}

/// Central product database for the Union Shop
class ProductDatabase {
  // Product categories
  static const List<ProductCategory> categories = [
    ProductCategory(name: 'Hoodies', imageAsset: 'assets/images/hoodies.png'),
    ProductCategory(
        name: 'Sweatshirts', imageAsset: 'assets/images/sweatshirts.png'),
    ProductCategory(
        name: 'Notebooks', imageAsset: 'assets/images/notebook.png'),
    ProductCategory(name: 'Notepads', imageAsset: 'assets/images/notepad.png'),
    ProductCategory(name: 'Hats', imageAsset: 'assets/images/hat.png'),
    ProductCategory(name: 'Cups', imageAsset: 'assets/images/cup.png'),
  ];

  // All products in the store
  static const List<Product> allProducts = [
    // Hoodies
    Product(
      id: 'hoodie_001',
      title: 'Classic Hoodie',
      price: '£25.00',
      category: 'Hoodies',
      imageAsset: 'assets/images/hoodies.png',
      description: 'Comfortable classic hoodie with university branding',
    ),
    Product(
      id: 'hoodie_002',
      title: 'Purple Hoodie',
      price: '£27.00',
      category: 'Hoodies',
      imageAsset: 'assets/images/hoodies.png',
      description: 'Stylish purple hoodie perfect for campus life',
    ),
    Product(
      id: 'hoodie_003',
      title: 'Green Hoodie',
      price: '£23.00',
      category: 'Hoodies',
      imageAsset: 'assets/images/hoodies.png',
      description: 'Vibrant green hoodie with premium quality',
    ),

    // Sweatshirts
    Product(
      id: 'sweatshirt_001',
      title: 'Classic Sweatshirt',
      price: '£23.00',
      category: 'Sweatshirts',
      imageAsset: 'assets/images/sweatshirts.png',
      description: 'Classic crewneck sweatshirt for everyday wear',
    ),
    Product(
      id: 'sweatshirt_002',
      title: 'Grey Sweatshirt',
      price: '£20.00',
      category: 'Sweatshirts',
      imageAsset: 'assets/images/sweatshirts.png',
      description: 'Comfortable grey sweatshirt with university logo',
    ),

    // Notebooks
    Product(
      id: 'notebook_001',
      title: 'A5 Notebook',
      price: '£3.00',
      category: 'Notebooks',
      imageAsset: 'assets/images/notebook.png',
      description: 'A5 lined notebook perfect for lectures and notes',
    ),
    Product(
      id: 'notebook_002',
      title: 'Hardback Notebook',
      price: '£6.00',
      category: 'Notebooks',
      imageAsset: 'assets/images/notebook.png',
      description: 'Durable hardback notebook with quality paper',
    ),

    // Notepads
    Product(
      id: 'notepad_001',
      title: 'A5 Notepad',
      price: '£1.80',
      category: 'Notepads',
      imageAsset: 'assets/images/notepad.png',
      description: 'Convenient A5 notepad for quick notes',
    ),

    // Hats
    Product(
      id: 'hat_001',
      title: 'University Hat',
      price: '£12.00',
      category: 'Hats',
      imageAsset: 'assets/images/hat.png',
      description: 'Stylish university branded hat',
    ),

    // Cups
    Product(
      id: 'cup_001',
      title: 'Union Mug',
      price: '£5.00',
      category: 'Cups',
      imageAsset: 'assets/images/cup.png',
      description: 'Union branded ceramic mug',
    ),
  ];

  /// Get all products in a specific category
  static List<Product> getProductsByCategory(String category) {
    return allProducts.where((p) => p.category == category).toList();
  }

  /// Get a single product by ID
  static Product? getProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search products by title
  static List<Product> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return allProducts
        .where((p) => p.title.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Get products within a price range
  static List<Product> getProductsByPriceRange(double min, double max) {
    return allProducts
        .where((p) => p.priceValue >= min && p.priceValue <= max)
        .toList();
  }

  /// Get all unique categories
  static List<String> getAllCategories() {
    return categories.map((c) => c.name).toList();
  }
}
