import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  final Timestamp dateTime;
  double weight;
  String id;

  WeightModel({required this.dateTime, required this.weight, this.id = ""});

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'date_time': dateTime,
    };
  }

  factory WeightModel.fromFirestore(
          Map<String, dynamic> firestore, String docId) =>
      WeightModel(
        id: docId,
        dateTime: firestore['date_time'],
        weight: firestore['weight'],
      );
}
