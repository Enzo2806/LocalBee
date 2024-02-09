class Offer {
  String productName;
  bool isDiscount;
  double?
      discount; // Nullable because it might not be applicable for a fixed price offer
  double?
      price; // Nullable because it might not be applicable for a discount offer

  Offer({
    required this.productName,
    this.isDiscount =
        true, // default to true, assuming most offers are discounts
    this.discount,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'isDiscount': isDiscount,
      'discount': discount,
      'price': price,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      productName: map['productName'],
      isDiscount: map.containsKey('discount'),
      discount: map['discount'],
      price: map['price'],
    );
  }
}
