// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class DriverModel {
  final String carImg;
  final String carModel;
  final String id;
  final double lat;
  final double long;
  final String name;
  final double rating;
  DriverModel({
    required this.carImg,
    required this.carModel,
    required this.id,
    required this.lat,
    required this.long,
    required this.name,
    required this.rating,
  });

  DriverModel copyWith({
    String? carImg,
    String? carModel,
    String? id,
    double? lat,
    double? long,
    String? name,
    double? rating,
  }) {
    return DriverModel(
      carImg: carImg ?? this.carImg,
      carModel: carModel ?? this.carModel,
      id: id ?? this.id,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      name: name ?? this.name,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carImg': carImg,
      'carModel': carModel,
      'id': id,
      'lat': lat,
      'long': long,
      'name': name,
      'rating': rating,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      carImg: map['carImg'] as String,
      carModel: map['carModel'] as String,
      id: map['id'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
      name: map['name'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DriverModel(carImg: $carImg, carModel: $carModel, id: $id, lat: $lat, long: $long, name: $name, rating: $rating)';
  }

  @override
  bool operator ==(covariant DriverModel other) {
    if (identical(this, other)) return true;

    return other.carImg == carImg &&
        other.carModel == carModel &&
        other.id == id &&
        other.lat == lat &&
        other.long == long &&
        other.name == name &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return carImg.hashCode ^
        carModel.hashCode ^
        id.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        name.hashCode ^
        rating.hashCode;
  }
}
