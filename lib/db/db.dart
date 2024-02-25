import 'package:postgres/postgres.dart';

class DB{
  
  PostgreSQLConnection? conexion = PostgreSQLConnection('dumbo.db.elephantsql.com', 5432, 'hjtkdjnd', username: 'hjtkdjnd', password: 'W5JAZLYguuhy9pyFrHDiFa5QYcsnu78c');

  conectar() async {
    if (conexion?.isClosed == true) await conexion?.open();
  }

  desconectar(){
    conexion?.close();
  }

  /////////////////////////////////////////////////////////////////
  ///                                                           ///
  ///     FUNCIONES PARA LAS TAREAS                             ///
  ///                                                           ///
  /////////////////////////////////////////////////////////////////
  
  // Función para ejecuciones de sentencias bd:
  Future<List<Map<String, Map<String, dynamic>>>> ejecutar(String sentencia) async{
    List<Map<String, Map<String, dynamic>>> resultado = [];

    await conectar();

    try{
      resultado = await conexion!.mappedResultsQuery(sentencia);
      return resultado;
    } catch(e){
      print('ERROR: $e');
      return [];
    } 
  }

  // Devolver todas las tareas:
  Future<List<Map<String, dynamic>>> users() async{
    return await ejecutar("select * from users");
  }

}