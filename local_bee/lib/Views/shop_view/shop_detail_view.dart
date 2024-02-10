import 'package:flutter/material.dart';
import 'package:local_bee/Model/LocalShop.dart';
import 'package:local_bee/Model/Offer.dart';
import 'package:local_bee/Views/shop_view/offer_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailView extends StatelessWidget {
  final LocalShop localShop;

  const ShopDetailView({Key? key, required this.localShop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localShop.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  localShop.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(1), Colors.transparent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        localShop.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        localShop.serviceType,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${localShop.address.streetName} ${localShop.address.number}, ${localShop.address.city}, ${localShop.address.postalCode}',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Here goes the description of the shop, which could be fetched from the database or set as a static content for each shop.',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Light grey background
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            const Text(
                              'Rating: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              localShop.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),

                        // Visit Website Link
                        if (localShop.webSite.isNotEmpty)
                          InkWell(
                            onTap: () => _launchURL(localShop.webSite),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min, // Use minimum space
                              children: [
                                Icon(Icons.link,
                                    color: Colors.green[800]), // Web icon
                                const SizedBox(
                                    width: 8), // Spacing between icon and text
                                Text(
                                  'Visit Website',
                                  style: TextStyle(color: Colors.green[800]),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Offers',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (localShop.offers.isEmpty)
                    const Text(
                      'No offers available at the moment.',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  if (localShop.offers.isNotEmpty)
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: localShop.offers.length,
                        itemBuilder: (context, index) {
                          Offer offer = localShop.offers[index];
                          return Padding(
                              padding: const EdgeInsets.all(7),
                              child: OfferDetailView(offer: offer));
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
