// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
 
  final String name;
  final String email;
  final double lat;
  final double long;

  UserModel({
    required this.name,
    required this.email,
    required this.lat,
    required this.long,
  });

  UserModel copyWith({
    String? name,
    String? email,
    double? lat,
    double? long,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  static final empty = UserModel( name: '', email: '',lat: 37.7749,long: -122.4194);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'lat': lat,
      'long': long,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.lat == lat &&
      other.long == long;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      lat.hashCode ^
      long.hashCode;
  }
}
