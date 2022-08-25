import 'package:android_assignment/database/mydatabase.dart';

class DatabaseInstance {
  static DatabaseInstance? _instance;
  DatabaseInstance._();
  static DatabaseInstance get instance => _instance ??= DatabaseInstance._();

  Future<AppDatabase> getDatabaseInstance() {
    return $FloorAppDatabase.databaseBuilder('PhotoHub_db').build();
  }
}
