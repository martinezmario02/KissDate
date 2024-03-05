import 'package:postgres/postgres.dart';

class DB {
  PostgreSQLConnection? conexion = PostgreSQLConnection(
      'dumbo.db.elephantsql.com', 5432, 'hjtkdjnd',
      username: 'hjtkdjnd', password: 'W5JAZLYguuhy9pyFrHDiFa5QYcsnu78c');

  conectar() async {
    if (conexion?.isClosed == true) await conexion?.open();
  }

  desconectar() {
    conexion?.close();
  }

  /////////////////////////////////////////////////////////////////
  ///                                                           ///
  ///     FUNCIONES PARA LOS USUARIOS                           ///
  ///                                                           ///
  /////////////////////////////////////////////////////////////////

  // Función para ejecuciones de sentencias bd:
  Future<List<Map<String, Map<String, dynamic>>>> ejecutar(
      String sentencia) async {
    List<Map<String, Map<String, dynamic>>> resultado = [];

    await conectar();

    try {
      resultado = await conexion!.mappedResultsQuery(sentencia);
      return resultado;
    } catch (e) {
      print('ERROR: $e');
      return [];
    }
  }

  // Devolver todos los usuarios:
  Future<List<Map<String, dynamic>>> users() async {
    return await ejecutar("select * from users");
  }

  // Añadir un usuario:
  Future<List<Map<String, dynamic>>> addUser(
      String name, String email, DateTime birthday, String password) async {
    return await ejecutar(
        "insert into users (name, mail, birthday, password) values ('$name', '$email', '$birthday', '$password')");
  }

  // Inicio de sesión:
  Future<int> login(String email, String password) async {
    var resultado = [];
    resultado = await ejecutar(
        "select user_id from users where mail='$email' and password='$password'");
    if (resultado.isEmpty) {
      return -1;
    } else {
      return resultado[0]['users']['user_id'];
    }
  }

  /////////////////////////////////////////////////////////////////
  ///                                                           ///
  ///     FUNCIONES PARA LAS LISTAS                             ///
  ///                                                           ///
  /////////////////////////////////////////////////////////////////

  // Añadir una persona a la lista:
  Future<List<Map<String, dynamic>>> addToList(
      int userId,
      String name,
      int age,
      String nationality,
      String relationship,
      DateTime kissDate,
      String observations) async {
    return await ejecutar(
        "insert into list (user_id, name, age, nationality, relationship, kiss_date, observations) values ($userId, '$name', $age, '$nationality', '$relationship', '$kissDate', '$observations')");
  }

  // Devolver todas las personas de la lista asociado a un usuario:
  Future<List<Map<String, dynamic>>> list(int userId) async {
    return await ejecutar("select * from list where user_id=$userId");
  }

  // Eliminar una persona de la lista:
  Future<void> deleteFromList(int personId) async {
    await ejecutar("delete from list where person_id=$personId");
  }

  // Devolver una persona de la lista:
  Future<Map<String, dynamic>> person(int personId) async {
    List<Map<String, dynamic>> result =
        await ejecutar("select * from list where person_id=$personId");
    return result.isNotEmpty
        ? result[0]
        : {}; // Devolver el primer elemento si hay resultados, de lo contrario, devolver un mapa vacío
  }
}
