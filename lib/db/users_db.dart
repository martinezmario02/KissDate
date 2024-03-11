import 'package:bcrypt/bcrypt.dart';
import 'db.dart';

/// Class that represents the database for users.
class UserDB extends DB {
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
  ///
  /// Returns the list of users.
  Future<List<Map<String, dynamic>>> addUser(
      String name, String email, DateTime birthday, String password) async {
    String salt = BCrypt.gensalt();
    String hashedPassword = BCrypt.hashpw(password, salt);

    return await ejecutar(
        "INSERT INTO users (name, mail, birthday, password, salt) VALUES ('$name', '$email', '$birthday', '$hashedPassword', '$salt')");
  }

  /// Login a user.
  ///
  /// [email] - Email of the user.
  /// [password] - Password of the user.
  ///
  /// Returns the identifier of the user if the login is successful, -1 otherwise.
  Future<int> login(String email, String password) async {
    var result = [];
    result = await ejecutar("select * from users where mail='$email'");

    if (result.isEmpty) {
      return -1;
    } else {
      var salt = result[0]['users']['salt'];
      var storedPassword = result[0]['users']['password'];

      if (salt != null && storedPassword != null) {
        var hashedPassword = BCrypt.hashpw(password, salt);

        if (hashedPassword == storedPassword) {
          return result[0]['users']['user_id'];
        } else {
          return -1;
        }
      } else {
        if (storedPassword == password) {
          return result[0]['users']['user_id'];
        }
        return -1;
      }
    }
  }
}
