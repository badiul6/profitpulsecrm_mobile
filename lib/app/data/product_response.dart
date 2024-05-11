class ProductResponse {
  String name;
  String? description;  // Optional since some products do not have a description
  int quantity;
  double unitPrice;

  ProductResponse({
    required this.name,
    this.description,
    required this.quantity,
    required this.unitPrice,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'].toDouble(), // Make sure to handle types correctly
    );
  }
}
