import 'package:kissdate/db/users_db.dart';

/// Instance of the database for users.
UserDB db = UserDB();

/// Controller for users.
class UserController {
  /// Get the list of users.
  Future<List<Map<String, dynamic>>> users() async {
    return await db.users();
  }

  /// Add a user.
  ///
  /// [name] - Name of the user.
  /// [email] - Email of the user.
  /// [birthday] - Date of birth of the user.
  /// [password] - Password of the user.
  Future<List<Map<String, dynamic>>> addUser(
      String name, String email, DateTime birthday, String password) async {
    return await db.addUser(name, email, birthday, password);
  }

  /// Login a user.
  ///
  /// [email] - Email of the user.
  /// [password] - Password of the user.
  ///
  /// Returns the identifier of the user if the login is successful, -1 otherwise.
  Future<int> login(String email, String password) async {
    return await db.login(email, password);
  }
}