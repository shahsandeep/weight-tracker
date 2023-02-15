import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/services/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  LoadingStatus _loadingStatus = LoadingStatus.loaded;

  Future<bool> login() async {
    String toast = "";
    setLoadingStatus(LoadingStatus.loading);
    bool response = await _firebaseAuthService.logIn();
    setLoadingStatus(LoadingStatus.loaded);

    if (response) {
      toast = "Login Successful";
    } else {
      toast = "Something went wrong please try again";
    }
    Fluttertoast.showToast(msg: toast);
    ChangeNotifier();
    return response;
  }

  Future<bool> logout() async {
    String toast = "";
    setLoadingStatus(LoadingStatus.loading);

    bool response = await _firebaseAuthService.logOut();
    setLoadingStatus(LoadingStatus.loaded);
    if (response) {
      toast = "Logout Successful";
    } else {
      toast = "Something went wrong please try again";
    }
    Fluttertoast.showToast(msg: toast);
    return response;
  }

  setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;
}
