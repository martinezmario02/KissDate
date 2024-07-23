import 'package:kissdate/db/wrapped_db.dart';

/// Instance of the database for wrapped.
WrappedDB db = WrappedDB();

/// Controller for statistics.
class WrappedController {
  /// Get the statistics of the age of the people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  ///
  /// Returns a map with the following keys:
  Future<Map<String, int?>> ageStatistics(int userId) async {
    return await db.ageStatistics(userId);
  }
  
  Future<Map<String, double?>> monthsStatistics(int userId) async {
    return await db.monthsStatistics(userId);
  }

  Future<Map<String, int?>> nationalityStatistics(int userId) async {
    return await db.nationalityStatistics(userId);
  }

  Future<Map<String, double?>> genderStatistics(int userId) async {
    return await db.genderStatistics(userId);
  }
}
