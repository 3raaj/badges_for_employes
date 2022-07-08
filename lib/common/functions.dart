import '../model/user.dart';

List<String> getAllUsernamesList({required List<User> dataBaseUserList}) {
  final List<String> dataBaseUserIdList = [];
  dataBaseUserList.forEach((element) {
    dataBaseUserIdList.add(element.userName);
  });
return dataBaseUserIdList;
}

bool checkPassword(
    {required String password, required String dataBasePassword}) {
  if (password == dataBasePassword) {
    return true;
  } else {
    return false;
  }
}

User searchUser(List<User> dataBaseUserList, String userName) {
  return dataBaseUserList.firstWhere((element) => element.userName == userName.toLowerCase());
}
