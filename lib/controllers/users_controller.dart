import '../db/db.dart';

DB db = DB();

class UserController{
  Future<List<Map<String, dynamic>>> users() async{
    return await db.users();
  }
}