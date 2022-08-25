import '../entity/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class Userdao {
  @Query('Select * from FUser')
  Future<List<FUser>> findAllUsers();

  @Query('Select * from FUser where id= :id')
  Future<FUser?> findUserById(int id);

  @insert
  Future<int> insertUser(FUser user);
}
