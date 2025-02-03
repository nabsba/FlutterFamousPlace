import '../../../client/providers/clientProvider.dart';
import '../../../sqllite/createDatabase.dart';

class UserInfosCRUD {
  // Create
  Future<int> addUser(UserInfos user) async {
    final db = await DatabaseHelper.instance.database;
    //
    return await db.insert('userinfos', user.toMap());
  }

  // Read All
  Future<List<UserInfos>> getAllUsers() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('userinfos');
    return result.map((map) => UserInfos.fromMap(map)).toList();
  }

  // Read One
  Future<UserInfos?> getUserById(String id) async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.query('userinfos', where: 'id = $id', whereArgs: [id]);

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
      where: 'id = ${user.userId} ',
      // whereArgs: [user.id],
    );
  }

  // Delete
  Future<int> deleteUser(String id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('userinfos', where: 'id = $id', whereArgs: [id]);
  }

  Future<int> deleteAllUsers() async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('userinfos');
  }

  Future<int> handleAddNewUser(UserInfos user) async {
    await DatabaseHelper.instance.database;
    // Check if the user exists
    final existingUser = await getAllUsers();
    if (existingUser.isNotEmpty) {
      // If the user exists, update it
      return await updateUser(user);
    } else {
      // If the user does not exist, add a new one
      return await addUser(user);
    }
  }
}
