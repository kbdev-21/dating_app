import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String bio;
  final String avtUrl;
  final String email;
  final String password;
  final Map<String, bool> liked;
  final Map<String, bool> matched;
  final int birthYear;

  User({
    required this.id,
    required this.name,
    required this.bio,
    required this.avtUrl,
    required this.email,
    required this.password,
    required this.liked,
    required this.matched,
    required this.birthYear,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      avtUrl: json['avtUrl'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      liked: (json['liked'] != null && json['liked'] is Map<String, dynamic>)
          ? Map<String, bool>.from(json['liked'])
          : {},
      matched: (json['matched'] != null && json['matched'] is Map<String, dynamic>)
          ? Map<String, bool>.from(json['matched'])
          : {},
      birthYear: json['birthYear'] ?? 0,
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'bio': bio,
      'avtUrl': avtUrl,
      'email': email,
      'password': password,
      'liked': liked,
      'matched': matched,
      'birthYear': birthYear,
    };
  }
}
