import 'package:local_bee/Controller/weekly_quiz_controller.dart';
import 'package:local_bee/Model/Question.dart';
import 'package:local_bee/model/Address.dart';
import 'package:local_bee/Controller/local_shop_controller.dart';
import 'package:local_bee/Model/LocalShop.dart';
import 'package:local_bee/Model/Offer.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';

class AppConstants {
  static const String britishFlagPath = 'assets/flags/ca-flag.jpeg';
  static const String montrealSustainable =
      'assets/images/montreal_sustainable.jpeg';
  static const String frenchFlagPath = 'assets/flags/ca-flag.jpeg';

  void createSampleShops() {
    List<LocalShop> shops = [
      LocalShop(
        name: 'Magasin Général du Vieux-Montréal',
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
        webSite: 'http://www.lemagasingeneral.biz/#!bistro/cihc',
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
        offers: [
          Offer(
            productName: "Avocado Toast",
            price: 10.99,
          ),
          Offer(
            productName: "Cappuccino",
            price: 3.99,
          ),
        ],
        imageUrl:
            'https://lh3.googleusercontent.com/p/AF1QipPfnLhC8bGWIv2na3f6QsLV5zt036RWzhOp-VBS=s1360-w1360-h1020',
        webSite:
            'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjJr8fPp5-EAxWAGFkFHcBzCawQFnoECAgQAQ&url=https%3A%2F%2Ftommycafe.ca%2F&usg=AOvVaw3l7E8-xjEI1yXlPH_C87lp&opi=89978449',
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
          offers: [
            Offer(
              productName: "Poutine",
              price: 7.99,
            )
          ], // Add any offers if available
          imageUrl:
              'https://lh3.googleusercontent.com/p/AF1QipMSYMR0ZVcB00y_Qm2lux-s_EWg7NsshgP_hH7X=s1360-w1360-h1020',
          webSite:
              'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiNlsLdp5-EAxUNFVkFHdguDawQFnoECBAQAQ&url=https%3A%2F%2Fpatatimontreal.ca%2Ffr&usg=AOvVaw3OUKGPt5XT_d-dU3-dsg_y&opi=89978449'),
      LocalShop(
          name: 'La Baraque',
          address: Address(
            streetName: 'R. Saint-Vincent',
            number: '401',
            city: 'Montréal',
            postalCode: 'H2Y 3A4',
          ),
          serviceType: 'Restaurant',
          rating: 3.8,
          offers: [], // Add any offers if available
          imageUrl:
              'https://lh3.googleusercontent.com/p/AF1QipNRq4rQdBCT08tlisBdEfQI4RB4xkqUi8iwUI-b=s1360-w1360-h1020',
          webSite:
              'https://facebook.com/labaraque/albums/707934558004730/?paipv=0&eav=Afaswaf_yzmAweXG8I4UPBqhaYeEkxnzuZmwc_utJ2-kacGxooOlwPlNXe32y0orPYk'),
    ];

    for (LocalShop shop in shops) {
      LocalShopController().saveLocalShop(shop);
    }
  }

  void createSampleQuizzes() {
    // Quiz 1
    List<Question> quiz1Questions = [
      Question(
        questionText:
            "What is the most common type of recycling bin in Montreal?",
        options: ["Blue bin", "Green bin", "Yellow bin"],
        answerIndex: 0,
        pointsAwarded: 10,
      ),
      Question(
        questionText:
            "Which organization in Montreal promotes sustainable transportation options?",
        options: ["STM", "McGill University", "Tim Hortons"],
        answerIndex: 0,
        pointsAwarded: 10,
      ),
      Question(
        questionText:
            "Which river flows through Montreal and has a history of pollution?",
        options: ["Saint Lawrence River", "Amazon River", "Nile River"],
        answerIndex: 0,
        pointsAwarded: 10,
      ),
    ];

    // Quiz 2
    List<Question> quiz2Questions = [
      Question(
        questionText:
            "What percentage of waste in Montreal is diverted from landfills?",
        options: ["50%", "75%", "90%"],
        answerIndex: 2,
        pointsAwarded: 10,
      ),
      Question(
        questionText:
            "Which park in Montreal is an example of urban sustainability?",
        options: ["Mount Royal Park", "Disneyland", "Central Park"],
        answerIndex: 0,
        pointsAwarded: 10,
      ),
      Question(
        questionText:
            "What is the goal of Montreal's Sustainable Development Plan?",
        options: [
          "Reduce greenhouse gas emissions",
          "Increase pollution",
          "Cut down all trees"
        ],
        answerIndex: 0,
        pointsAwarded: 10,
      ),
    ];

    // Create a list of weekly quizzes
    List<WeeklyQuiz> quizzes = [
      WeeklyQuiz(
        name: "Sustainability Quiz 1",
        questions: quiz1Questions,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
      ),
      WeeklyQuiz(
        name: "Sustainability Quiz 2",
        questions: quiz2Questions,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 14)),
      ),
    ];

    // Save the quizzes
    for (WeeklyQuiz quiz in quizzes) {
      WeeklyQuizController().saveQuiz(quiz);
    }
  }
}
