import '../db/db.dart';

DB db = DB();

class ListController {
  Future<List<Map<String, dynamic>>> addToList(
      int userId,
      String name,
      int age,
      String nationality,
      String relationship,
      DateTime kissDate,
      String observations) async {
    return await db.addToList(
        userId, name, age, nationality, relationship, kissDate, observations);
  }

  Future<List<Map<String, dynamic>>> list(int userId) async {
    return await db.list(userId);
  }

  Future<List<Map<String, dynamic>>> deleteFromList(int personId) async {
    return await db.deleteFromList(personId);
  }

  Future<Map<String, dynamic>> person(int personId) async {
    return await db.person(personId);
  }
}
