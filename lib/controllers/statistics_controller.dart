import 'package:kissdate/db/statistics_db.dart';

/// Instance of the database for statistics.
StatisticsDB db = StatisticsDB();

/// Controller for statistics.
class StatisticsController {
  /// Get the statistics of the gender of the people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  ///
  /// Returns a map with the following keys:
  ///   - 'hombres': Count of people identified as men.
  ///   - 'mujeres': Count of people identified as women.
  ///   - 'noBinario': Count of people identified as non-binary.
  ///   - 'sinEspecificar': Count of people who have not specified
  ///
  /// If there is an error, returns an empty map.
  Future<Map<String, double?>> genderStatistics(int userId) async {
    return await db.genderStatistics(userId);
  }

  /// Get the statistics of the age of the people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  ///
  /// Returns a map with the following keys:
  Future<Map<String, int?>> ageStatistics(int userId) async {
    return await db.ageStatistics(userId);
  }

  Future<Map<String, int?>> nationalityStatistics(int userId) async {
    return await db.nationalityStatistics(userId);
  }

  Future<Map<String, double?>> yearStatistics(int userId) async {
    return await db.yearStatistics(userId);
  }
}
