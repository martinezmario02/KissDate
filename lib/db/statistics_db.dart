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
}