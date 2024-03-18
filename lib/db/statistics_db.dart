import 'package:flutter/foundation.dart';
import 'db.dart';

/// Class that represents the database for statistics.
class StatisticsDB extends DB {
  /// Get the statistics of the gender of the people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  ///
  /// Returns a map with the following keys:
  ///   - 'hombres': Count of people identified as men.
  ///   - 'mujeres': Count of people identified as women.
  ///   - 'noBinario': Count of people identified as non-binary.
  ///   - 'sinEspecificar': Count of people who have not specified.
  ///
  /// If there is an error, returns an empty map.
  Future<Map<String, double?>> genderStatistics(int userId) async {
    var result = <String, double?>{};

    await conectar();

    try {
      /// SQL statement to count the number of people identified as men.
      var hombresResult = await conexion!.query(
        "SELECT COUNT(*) FROM list WHERE user_id = $userId AND gender = 'hombre'",
      );
      var hombresCount = double.tryParse(hombresResult.first[0].toString());
      result['hombres'] = hombresCount;

      /// SQL statement to count the number of people identified as women.
      var mujeresResult = await conexion!.query(
        "SELECT COUNT(*) FROM list WHERE user_id = $userId AND gender = 'mujer'",
      );
      var mujeresCount = double.tryParse(mujeresResult.first[0].toString());
      result['mujeres'] = mujeresCount;

      /// SQL statement to count the number of people identified as non-binary.
      var noBinarioResult = await conexion!.query(
        "SELECT COUNT(*) FROM list WHERE user_id = $userId AND gender = 'no binario'",
      );
      var noBinarioCount = double.tryParse(noBinarioResult.first[0].toString());
      result['noBinario'] = noBinarioCount;

      /// SQL statement to count the number of people who have not specified.
      var sinEspecificarResult = await conexion!.query(
        "SELECT COUNT(*) FROM list WHERE user_id = $userId AND gender = 'sin especificar'",
      );
      var sinEspecificarCount =
          double.tryParse(sinEspecificarResult.first[0].toString());
      result['sinEspecificar'] = sinEspecificarCount;

      return result;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return {};
    }
  }

  Future<Map<String, int?>> ageStatistics(int userId) async {
    var result = <String, int?>{};

    await conectar();

    try {
      /// SQL statement to get age statistics.
      var ageResult = await conexion!.query(
        "SELECT age, COUNT(*) FROM list WHERE user_id = $userId GROUP BY age",
      );

      for (var row in ageResult) {
        var age = row.first.toString();
        var count = int.tryParse(row[1].toString());
        result[age] = count;
      }

      return result;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return {};
    }
  }

  Future<Map<String, int?>> nationalityStatistics(int userId) async {
    var result = <String, int?>{};

    await conectar();

    try {
      /// SQL statement to get age statistics.
      var nationalityResult = await conexion!.query(
        "SELECT nationality, COUNT(*) FROM list WHERE user_id = $userId GROUP BY nationality",
      );

      for (var row in nationalityResult) {
        var nationality = row.first.toString();
        var count = int.tryParse(row[1].toString());
        result[nationality] = count;
      }

      return result;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return {};
    }
  }

  Future<Map<String, double?>> yearStatistics(int userId) async {
    var result = <String, double?>{};

    await conectar();

    try {
      /// SQL statement to get year statistics.
      var yearResult = await conexion!.query(
        "SELECT EXTRACT(YEAR FROM kiss_date) AS year, COUNT(*) FROM list WHERE user_id = $userId GROUP BY year",
      );

      for (var row in yearResult) {
        var year = row[0].toString();
        var count = double.tryParse(row[1].toString());
        result[year] = count;
      }

      return result;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return {};
    }
  }
}