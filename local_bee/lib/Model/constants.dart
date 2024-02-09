import 'package:local_bee/model/Address.dart';
import 'package:local_bee/Controller/local_shop_controller.dart';
import 'package:local_bee/Model/LocalShop.dart';

class AppConstants {
  static const String britishFlagPath = 'assets/flags/flag-english.png';
  static const String montrealSustainable =
      'assets/images/montreal_sustainable.jpeg';
  static const String frenchFlagPath = 'assets/flags/flag-france.png';

  void createSampleShops() {
    List<LocalShop> shops = [
      LocalShop(
        name: 'Le Walk-In du Magasin Général du Vieux-Montréal',
        address: Address(
          streetName: 'Rue Saint-Paul O',
          number: '34-C',
          city: 'Montréal',
          postalCode: 'H2Y 1Y8',
        ),
        serviceType: 'Boutique',
        rating: 4.6,
        offers: [],
        imageUrl:
            'https://lh3.googleusercontent.com/p/AF1QipNL_5XOhxFrTUfDvGhkzFCOi1LIS5IfUSnlrvb_=s1360-w1360-h1020',
      ),
      LocalShop(
        name: 'Tommy Café',
        address: Address(
          streetName: 'Notre-Dame St W',
          number: '200',
          city: 'Montréal',
          postalCode: 'H2Y 1T3',
        ),
        serviceType: 'Café',
        rating: 4.3,
        offers: [],
        imageUrl:
            'https://lh3.googleusercontent.com/p/AF1QipPfnLhC8bGWIv2na3f6QsLV5zt036RWzhOp-VBS=s1360-w1360-h1020',
      ),
      LocalShop(
        name: 'Patati Patata',
        address: Address(
          streetName: 'Boul. Saint-Laurent',
          number: '4177',
          city: 'Montréal',
          postalCode: 'H2W 1Y7',
        ),
        serviceType: 'Restaurant',
        rating: 4.4,
        offers: [], // Add any offers if available
        imageUrl:
            'https://lh3.googleusercontent.com/p/AF1QipMSYMR0ZVcB00y_Qm2lux-s_EWg7NsshgP_hH7X=s1360-w1360-h1020',
      ),
    ];

    for (LocalShop shop in shops) {
      LocalShopController().saveLocalShop(shop);
    }
  }
}
