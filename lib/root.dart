import 'package:kissdate/controllers/list_controller.dart';
import 'package:kissdate/controllers/users_controller.dart';
import 'package:kissdate/controllers/statistics_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controllers to manage the data.
final UserController userController = UserController();
final ListController peopleController = ListController();
final StatisticsController statsController = StatisticsController();

/// Global variables.
int userId = -1;
int personId = -1;
bool isLogged = false;

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

