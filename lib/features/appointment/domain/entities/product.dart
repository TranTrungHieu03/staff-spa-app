class Product {
  final int productId;
  final String productName;
  final String productDescription;
  final String skinTypeSuitable;
  final double price;
  final int quantity;
  final double volume;
  final String dimension;
  final double discount;
  final String status;
  final String brand;
  final int categoryId;
  final int companyId;
  final List<String>? images;

  Product({
    required this.skinTypeSuitable,
    this.images,
    required this.volume,
    required this.dimension,
    required this.productId,
    required this.brand,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.status,
    required this.categoryId,
    required this.companyId,
  });
}
