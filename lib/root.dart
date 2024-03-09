import 'package:kissdate/controllers/list_controller.dart';
import 'package:kissdate/controllers/users_controller.dart';
import 'package:kissdate/controllers/statistics_controller.dart';

/// Controllers to manage the data.
final UserController userController = UserController();
final ListController peopleController = ListController();
final StatisticsController statsController = StatisticsController();

/// Global variables.
int userId = -1;
int personId = -1;