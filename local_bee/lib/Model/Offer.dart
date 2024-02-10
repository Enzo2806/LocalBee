// ignore_for_file: file_names

class Offer {
  String productName;
  double
      price; // Nullable because it might not be applicable for a discount offer

  Offer({
    required this.productName,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      productName: map['productName'],
      price: map['price'],
    );
  }
}
