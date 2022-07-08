import 'package:badges_for_employes/common/exception.dart';
import 'package:badges_for_employes/common/functions.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:flutter/rendering.dart';

mixin ValidateLogin {
  // check user password -> if we have a user with that ID so do something . else do something...
  User? validateLogin(
      {required String userName,
      required List<User> dataBaseUserList,
      required String password}) {
    // first check existence the Id we recived from login page
    final List<String> dataBaseUserIdList =
        getAllUsernamesList(dataBaseUserList: dataBaseUserList);
    if (dataBaseUserIdList.contains(userName)) {
      final String userPasswordInDataBase =
          searchUser(dataBaseUserList, userName).password;
      final bool passwordResult = checkPassword(
          password: password, dataBasePassword: userPasswordInDataBase);
      if (passwordResult) {
        return searchUser(dataBaseUserList, userName);
      } else {
       return null;
      }
    }
     else {
      return null ; 
     }
  }
}
