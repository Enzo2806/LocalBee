import 'package:local_bee/model/Address.dart';
import 'package:local_bee/Model/Offer.dart';

class LocalShop {
  String name;
  Address address;
  // Replace with actual type of serviceType
  String serviceType;
  double rating;
  List<Offer> offers;
  String imageUrl;
  String webSite;

  LocalShop({
    required this.name,
    required this.address,
    required this.serviceType,
    required this.rating,
    required this.offers,
    required this.imageUrl,
    required this.webSite,
  });

// Converts a LocalShop instance into a Map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address.toMap(),
      'serviceType': serviceType,
      'rating': rating,
      // Handles the case where 'offers' might be null
      'offers': offers.map((offer) => offer.toMap()).toList() ?? [],
      'imageUrl': imageUrl,
      'webSite': webSite,
    };
  }

// Creates a LocalShop instance from a map.
  factory LocalShop.fromMap(Map<String, dynamic> map) {
    var offersList = map['offers'] != null
        ? List<Offer>.from(
            map['offers'].map((offerMap) => Offer.fromMap(offerMap)))
        : <Offer>[];
    return LocalShop(
      name: map['name'],
      address: Address.fromMap(map['address']),
      serviceType: map['serviceType'],
      rating: map['rating']
          .toDouble(), // Make sure to handle conversion if necessary
      offers: offersList,
      imageUrl: map['imageUrl'],
      webSite: map['webSite'],
    );
  }
}
