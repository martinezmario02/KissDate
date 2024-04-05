import 'package:bcrypt/bcrypt.dart';
import 'db.dart';

/// Class that represents the database for users.
class UserDB extends DB {
  /// Get the list of users.
  Future<List<Map<String, dynamic>>> users() async {
    return await ejecutar("SELECT * FROM users");
  }

  /// Add a user.
  ///
  /// [username] - Username associated with the user.
  /// [name] - Name of the user.
  /// [birthday] - (Optional) Birthday of the user.
  /// [password] - Password of the user.
  /// [email] - (Optional)Email of the user.
  ///
  /// Returns the list of users.
  Future<List<Map<String, dynamic>>> addUser(String username, String name,
      DateTime? birthday, String password, String? email) async {
    String salt = BCrypt.gensalt();
    String hashedPassword = BCrypt.hashpw(password, salt);

    String query = '''
    INSERT INTO Usuarios (username, name, password, salt${birthday != null ? ', birthday' : ''}${email != null ? ', email' : ''})
    VALUES ('$username', '$name', '$hashedPassword', '$salt'${birthday != null ? ", '$birthday'" : ''}${email != null ? ", '$email'" : ''})
    ''';

    return await ejecutar(query);
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

  /// Check if a user exists by username.
  ///
  /// [username] - Username of the user.
  /// Returns true if the user exists, false otherwise.
  Future<bool> userExists(String username) async {
    var result = await ejecutar("SELECT * FROM users WHERE username='$username'");
    return result.isNotEmpty;
  }
}