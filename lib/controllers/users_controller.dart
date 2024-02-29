import '../db/db.dart';

DB db = DB();

class UserController{
  Future<List<Map<String, dynamic>>> users() async{
    return await db.users();
  }

  Future<List<Map<String, dynamic>>> addUser(String name, String email, DateTime birthday, String password) async{
    return await db.addUser(name, email, birthday, password);
  }

  Future<int> login(String email, String password) async{
    return await db.login(email, password);
  }
}