enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  const Product({
    required this.id,
    required this.isFeatured,
    required this.category,
    required this.name,
    required this.price,
  });
  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  String get assetName => '$id-0jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() {
    // TODO: implement toString
    return '$name (id=$id)';
  }
}
