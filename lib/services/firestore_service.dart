import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_weight_tracker/models/common_response_mode.dart';
import 'package:firestore_weight_tracker/models/weight_model.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<CommonResponse> addWeight(WeightModel weight) async {
    try {
      await _db.collection('userWeight').doc().set(
            weight.toMap(),
          );
      return CommonResponse(message: 'Added Succesfully', status: true);
    } catch (e) {
      return CommonResponse(
          message: 'Something Went Wrong Please Try Again', status: false);
    }
  }

  Future<CommonResponse> updateWeight(WeightModel weight) async {
    try {
      await _db.collection('userWeight').doc(weight.id).update(
            weight.toMap(),
          );
      return CommonResponse(message: 'Updated Succesfully', status: true);
    } catch (e) {
      return CommonResponse(
          message: 'Something Went Wrong Please Try Again', status: false);
    }
  }

  Stream<List<WeightModel>> getWeightList() {
    return _db
        .collection('userWeight')
        .orderBy('date_time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) =>
                WeightModel.fromFirestore(document.data(), document.id))
            .toList());
  }

  Future<CommonResponse> deleteWeight(String productId) async {
    try {
      await _db.collection('userWeight').doc(productId).delete();
      return CommonResponse(message: 'Deleted Succefully', status: true);
    } catch (e) {
      return CommonResponse(
          message: 'Something Went Wrong Please Try Again', status: false);
    }
  }
}
