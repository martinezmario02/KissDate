import 'package:kissdate/controllers/list_controller.dart';
import 'package:kissdate/controllers/users_controller.dart';
import 'package:kissdate/controllers/statistics_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

/// Controllers to manage the data.
final UserController userController = UserController();
final ListController peopleController = ListController();
final StatisticsController statsController = StatisticsController();

/// Global variables.
int userId = -1;
int personId = -1;
bool isLogged = false;

/// Logger to print messages.
final logger = Logger();

/// Check if the user is logged in.
Future<bool> isLoggedStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLogged') ?? false;
  return isLoggedIn;
}

/// Check the status of the user.
Future<void> checkLoggedStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogged', isLoggedIn);
}

/// Save the user ID.
Future<void> saveUserId(int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userId);
}

/// Get the user ID.
Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');
  return userId;
}