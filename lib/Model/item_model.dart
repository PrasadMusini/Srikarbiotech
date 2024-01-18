class Item {
  String name;
  String unit;
  double price;
  int productquanatity;
  String image;
  int discount;
  int initalprice;
  int id;

  Item(
      {required this.name,
      required this.unit,
      required this.price,
      required this.productquanatity,
      required this.image,
      required this.discount,
      required this.initalprice,
      required this.id});

  // Named constructor for JSON parsing
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        name: json['name'] ?? '',
        unit: json['unit'] ?? '',
        price: json['price'] ?? 0.0,
        productquanatity: json['productquanatity'] ?? 0,
        image: json['image'] ?? '',
        initalprice: json['initalprice'] ?? 0,
        discount: json['discount'] ?? '',
        id: json['id'] ?? 0);
  }
}
