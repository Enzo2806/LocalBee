// Example User Profile Model
class UserProfile {
  String userId;
  String name;
  String familyName;
  String email;
  String preferredLanguage;
  int points;

  UserProfile({
    required this.userId,
    required this.name,
    required this.familyName,
    required this.email,
    required this.preferredLanguage,
    this.points = 0,
  });

  // Method to convert UserProfile to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'familyName': familyName,
      'email': email,
      'preferredLanguage': preferredLanguage,
      'points': points,
    };
  }

  // Method to create a UserProfile from Firestore document
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'],
      name: map['name'],
      familyName: map['familyName'],
      email: map['email'],
      preferredLanguage: map['preferredLanguage'],
      points: map['points'],
    );
  }
}
