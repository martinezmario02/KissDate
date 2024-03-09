import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

/// Class that represents the database.
class DB {
  /// Connection to the database postgreSQL.
  PostgreSQLConnection? conexion = PostgreSQLConnection(
      'dumbo.db.elephantsql.com', 5432, 'hjtkdjnd',
      username: 'hjtkdjnd', password: 'W5JAZLYguuhy9pyFrHDiFa5QYcsnu78c');

  /// Open the connection to the database.
  ///
  /// If the connection is already open, it does nothing.
  conectar() async {
    if (conexion?.isClosed == true) await conexion?.open();
  }

  /// Close the connection to the database.
  desconectar() {
    conexion?.close();
  }

  /// Execute a SQL statement and return the results.
  ///
  /// [sentencia] - SQL statement to execute.
  ///
  /// Returns a list of maps, where each map contains column names and associated row values.
  ///
  /// If there is an error, returns an empty list.
  Future<List<Map<String, Map<String, dynamic>>>> ejecutar(
      String sentencia) async {
    List<Map<String, Map<String, dynamic>>> result = [];

    await conectar();

    try {
      result = await conexion!.mappedResultsQuery(sentencia);
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
      return [];
    }
  }
}
