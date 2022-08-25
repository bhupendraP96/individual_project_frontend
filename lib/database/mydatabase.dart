import 'dart:async';
import 'package:android_assignment/dao/userdao.dart';
import 'package:android_assignment/entity/user.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'mydatabase.g.dart';

@Database(version: 1, entities: [FUser])
abstract class AppDatabase extends FloorDatabase {
  Userdao get userDao;
}
