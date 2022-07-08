import 'package:hive_flutter/adapters.dart';
part 'userRole.g.dart';

@HiveType(typeId: 5)
enum UserRole { 
  @HiveField(0)
  admin, 
  @HiveField(1)
  client, 
}