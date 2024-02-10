import 'package:flutter/material.dart';
import 'package:local_bee/Controller/user_controller.dart';
import 'package:local_bee/Model/User.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserController _userController = UserController();
  UserProfile? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    try {
      UserProfile? user = await _userController.getUserProfile();

      if (user != null) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      } else {
        // Handle the null user scenario, maybe by showing an error or a message
      }
    } catch (e) {
      // Handle the error, maybe by showing an error message
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white, // AppBar color
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.green[700], // Main color
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Icon(
                      Icons.card_giftcard,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    Text(
                      _user!.points.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Value of points: ${(_user!.points * 0.001).toStringAsFixed(2)} CAD",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "${_user!.name} ${_user!.familyName}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "XXXX_XXXX_XXXX_${_user!.userId.substring(_user!.userId.length - 4)}", // Masked card number or user id
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          const ListTile(
            title: Text(""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Earn points!",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Win points by correclty answering weekly quizzes or by scanning your card after purchasing any item in any Montreal local store! ",
                ),
                SizedBox(height: 10.0),
                Text(
                  "Spend points!",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Spend points on any item in a Montreal local store!",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          const ListTile(
            title: Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: <Widget>[
                Text("No recent activity",
                    style: TextStyle(color: Colors.grey)),
                // ActivityTile(
                //   icon: Icons.quiz,
                //   text: "You earned 20 points",
                //   amount: "+20",
                //   color: Colors.green,
                // ),
                // Divider(),
                // ActivityTile(
                //   icon: Icons.store,
                //   text: "You earned 123 points",
                //   amount: "+123",
                //   color: Colors.green,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String amount;
  final Color color;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.text,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(width: 8.0),
          Text(text),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              amount,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
