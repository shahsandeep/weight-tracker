import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/models/common_response_mode.dart';
import 'package:firestore_weight_tracker/models/weight_model.dart';
import 'package:flutter/Material.dart';
import 'package:firestore_weight_tracker/services/firestore_service.dart';

class WeightProvider extends ChangeNotifier {
  final FireStoreService _fireStoreService = FireStoreService();
  final List<WeightModel> _weightList = [];

  LoadingStatus _loadingStatus = LoadingStatus.loaded;

  getWeightList() {
    _fireStoreService.getWeightList().listen((event) {
      _weightList.clear();
      _weightList.addAll(event);
      notifyListeners();
    });
  }

  Future<CommonResponse> addWeight(String weight) async {
    setLoadingStatus(LoadingStatus.loading);
    double weightData = double.parse(weight);
    Timestamp dateTime = Timestamp.fromDate(DateTime.now());
    WeightModel data = WeightModel(dateTime: dateTime, weight: weightData);
    var response = await _fireStoreService.addWeight(data);
    setLoadingStatus(LoadingStatus.loaded);
    return response;
  }

  Future<CommonResponse> updateWeight(WeightModel updateData) async {
    setLoadingStatus(LoadingStatus.loading);
    var response = await _fireStoreService.updateWeight(updateData);
    setLoadingStatus(LoadingStatus.loaded);
    return response;
  }

  Future<CommonResponse> deleteWeight(String id) async {
    setLoadingStatus(LoadingStatus.loading);
    var response = await _fireStoreService.deleteWeight(id);
    setLoadingStatus(LoadingStatus.loaded);
    return response;
  }

  setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
    notifyListeners();
  }

  List<WeightModel> get weigthList => _weightList;

  LoadingStatus get loadingStatus => _loadingStatus;
}
