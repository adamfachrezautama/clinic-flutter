import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveUserData(LoginResponseModel data) async {
    // save user data to local storage
    final pref = await SharedPreferences.getInstance();
    await pref.setString('user', data.toJson());
  }

  //remove user data from local storage
  Future<void> removeUserData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('user');
  }

  //get user data from local storage
  Future<LoginResponseModel?> getUserData() async {
    final pref = await SharedPreferences.getInstance();
    final user = pref.getString('user');
    if (user != null) {
      return LoginResponseModel.fromJson(user);
    } else {
      return null;
    }
  }

  // get token
  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final user = pref.getString('user');
    if (user != null) {
      return LoginResponseModel.fromJson(user).data?.token;
    } else {
      return null;
    }
  }

  // check if user is logged in
  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    final user = pref.getString('user');
    return user != null;
  }

  //cek if user is new
  Future<bool> isNewUser() async {
    final pref = await SharedPreferences.getInstance();
    final user = pref.getString('user');
    if (user != null) {
      return LoginResponseModel.fromJson(user).data?.isNew ?? false;
    } else {
      return false;
    }
  }
}
