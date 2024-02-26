import '../db/db.dart';

DB db = DB();

class UserController{
  Future<List<Map<String, dynamic>>> users() async{
    return await db.users();
  }

  Future<List<Map<String, dynamic>>> addToList(String name, int age, String nationality, String relationship, DateTime kissDate, String observations) async{
    return await db.addToList(name, age, nationality, relationship, kissDate, observations);
  }
}