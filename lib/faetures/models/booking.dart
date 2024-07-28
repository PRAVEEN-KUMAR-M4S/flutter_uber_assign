// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uber_clone/faetures/models/driver_model.dart';

class Booking {
  final String status;
  final String rideId;
  final DriverModel driverModel;
  final String estamateTime;
  Booking({
    required this.status,
    required this.rideId,
    required this.driverModel,
    required this.estamateTime,
  });

  Booking copyWith({
    String? status,
    String? rideId,
    DriverModel? driverModel,
    String? estamateTime,
  }) {
    return Booking(
      status: status ?? this.status,
      rideId: rideId ?? this.rideId,
      driverModel: driverModel ?? this.driverModel,
      estamateTime: estamateTime ?? this.estamateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'rideId': rideId,
      'driverModel': driverModel.toMap(),
      'estamateTime': estamateTime,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      status: map['status'] as String,
      rideId: map['rideId'] as String,
      driverModel: DriverModel.fromMap(map['driverModel'] as Map<String,dynamic>),
      estamateTime: map['estamateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(status: $status, rideId: $rideId, driverModel: $driverModel, estamateTime: $estamateTime)';
  }

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.rideId == rideId &&
      other.driverModel == driverModel &&
      other.estamateTime == estamateTime;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      rideId.hashCode ^
      driverModel.hashCode ^
      estamateTime.hashCode;
  }
}
