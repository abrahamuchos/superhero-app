import 'package:flutter/material.dart';

class SuperheroDetailResponse {
  final String id;
  final String name;
  final String url;
  final String? realName;
  final PowerstatsResponse? powerstatsResponse;
  final AppearanceResponse? appearanceResponse;

  SuperheroDetailResponse({
    required this.id,
    required this.name,
    required this.url,
    required this.realName,
    required this.powerstatsResponse,
    required this.appearanceResponse,
  });

  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailResponse(
      id: json["id"],
      name: json["name"],
      url: json["image"]["url"],
      realName: json["biography"]["full-name"],
      powerstatsResponse: PowerstatsResponse.fromJson(json["powerstats"]),
      appearanceResponse: AppearanceResponse.fromJson(json["appearance"]),
    );
  }
}

class PowerstatsResponse {
  final double intelligence;
  final double strength;
  final double speed;
  final double durability;
  final double power;
  final double combat;

  PowerstatsResponse({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerstatsResponse.fromJson(Map<String, dynamic> json) {
    return PowerstatsResponse(
      intelligence: _cleanValue(json["intelligence"]),
      strength: _cleanValue(json["strength"]),
      speed: _cleanValue(json["speed"]),
      durability: _cleanValue(json["durability"]),
      power: _cleanValue(json["power"]),
      combat: _cleanValue(json["combat"]),
    );
  }

  /// Function to convert string or null into a double
  ///
  /// Sometimes [val] can be string, null or 'null'
  /// This function parse string o null into a double value
  static double _cleanValue(String? val) {
    if (val == 'null' || val == null) return 0.0;
    return double.parse(val);
  }
}

class AppearanceResponse {
  final bool? gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  AppearanceResponse({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  /// Getter to UI gender icon
  IconData get genderIcon{
    if(gender == null) return Icons.question_mark;
    return gender! ? Icons.male : Icons.female;
  }

  ///Getter to height
  String get heightMetric {
    if(height.length >= 2) return height[1];
    return height.isNotEmpty ? height[0] : 'N/A';
  }

  String get weightMetric{
    if(weight.length >= 2) return weight[1];
    return weight.isNotEmpty ? weight[0] : 'N/A';
 }

  factory AppearanceResponse.fromJson(Map<String, dynamic> json) {
    return AppearanceResponse(
      gender: _castGender(json["gender"]),
      race: json["race"],
      height: List<String>.from(json["height"]) ,
      weight: List<String>.from(json["weight"]),
      eyeColor: json["eye-color"],
      hairColor: json["hair-color"],
    );
  }

  static bool? _castGender(String? val){
    if(val == 'null' || val == null) return null;
    return val.toLowerCase() == 'male';
  }
}
