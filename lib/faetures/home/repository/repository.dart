import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/faetures/models/booking.dart';
import 'package:uber_clone/faetures/models/driver_model.dart';
import 'package:uber_clone/faetures/models/user_model.dart';

class FetchUserDataService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> fetchUserData() async {
    try {
      final docsnapshot = await _firebaseFirestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      final data = docsnapshot.data()!;

      return UserModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DriverModel>> fetchDriverData() async {
    try {
      final data = await _firebaseFirestore.collection('drivers').get().then(
          (val) => val.docs.map((e) => DriverModel.fromMap(e.data())).toList());
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> bookRide(Booking booking) async {
    try {
      await _firebaseFirestore
          .collection('drivers')
          .doc(booking.driverModel.id)
          .collection('bookings')
          .doc(booking.rideId)
          .set(booking.toMap());
      await _firebaseFirestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('bookings')
          .doc(booking.rideId)
          .set(booking.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Booking>> getBookingData() async {
    try {
      final booking = await _firebaseFirestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('bookings')
          .get()
          .then(
              (val) => val.docs.map((e) => Booking.fromMap(e.data())).toList());
      print(booking);
      if (booking.isEmpty) {
        throw 'No record found !';
      }
      return booking;
    } catch (e) {
      throw e.toString();
    }
  }
}
