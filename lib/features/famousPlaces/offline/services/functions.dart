import '../../../client/providers/clientProvider.dart';
import '../../../sqllite/createDatabase.dart';

class PlacesCRUD {
  // Create
  Future<int> addUser(UserInfos user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('userinfos', user.toMap());
  }

  // Read All
  Future<List<UserInfos>> getAllUsers() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('userinfos');
    return result.map((map) => UserInfos.fromMap(map)).toList();
  }

  // Read One
  Future<UserInfos?> getUserById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.query('userinfos', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return UserInfos.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Update
  Future<int> updateUser(UserInfos user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'userinfos',
      user.toMap(),
      where: 'id = ?',
      // whereArgs: [user.id],
    );
  }

  // Delete
  Future<int> deleteUser(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('userinfos', where: 'id = ?', whereArgs: [id]);
  }
}
