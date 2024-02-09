class Address {
  String streetName;
  String number;
  String city;
  String postalCode;
  String get fullAddress => '$number $streetName, $city, $postalCode';

  Address({
    required this.streetName,
    required this.number,
    required this.city,
    required this.postalCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'streetName': streetName,
      'number': number,
      'city': city,
      'postalCode': postalCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetName: map['streetName'],
      number: map['number'],
      city: map['city'],
      postalCode: map['postalCode'],
    );
  }
}
