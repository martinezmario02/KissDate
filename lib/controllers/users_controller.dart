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
  /// [username] - Username associated with the user.
  /// [name] - Name of the user.
  /// [email] - Email of the user.
  /// [birthday] - Date of birth of the user.
  /// [password] - Password of the user.
  ///
  Future<List<Map<String, dynamic>>> addUser(
      String username, String name,
      DateTime? birthday, String password, String? email) async {
    return await db.addUser(username, name, birthday, password, email);
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

  /// Check if a user exists.
  ///
  /// [username] - Username of the user.
  ///
  /// Returns true if the user exists, false otherwise.
  Future<bool> userExists(String username) async {
    return await db.userExists(username);
  }
}