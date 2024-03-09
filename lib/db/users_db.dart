import 'db.dart';

/// Class that represents the database for users.
class UserDB extends DB{

  /// Get the list of users.
  Future<List<Map<String, dynamic>>> users() async {
    return await ejecutar("select * from users");
  }

  /// Add a user.
  ///
  /// [name] - Name of the user.
  /// [email] - Email of the user.
  /// [birthday] - Date of birth of the user.
  /// [password] - Password of the user.
  Future<List<Map<String, dynamic>>> addUser(
      String name, String email, DateTime birthday, String password) async {
    return await ejecutar(
        "insert into users (name, mail, birthday, password) values ('$name', '$email', '$birthday', '$password')");
  }

  /// Login a user.
  ///
  /// [email] - Email of the user.
  /// [password] - Password of the user.
  ///
  /// Returns the identifier of the user if the login is successful, -1 otherwise.
  Future<int> login(String email, String password) async {
    var result = [];
    result = await ejecutar(
        "select user_id from users where mail='$email' and password='$password'");
    if (result.isEmpty) {
      return -1;
    } else {
      return result[0]['users']['user_id'];
    }
  }
}