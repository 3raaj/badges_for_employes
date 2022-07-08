import 'package:badges_for_employes/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class HiveUserDataSource {
  final Box<User> hiveUserBox;

  HiveUserDataSource(this.hiveUserBox);
}
