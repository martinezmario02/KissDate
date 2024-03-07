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
      String observations,
      String gender) async {
    return await db.addToList(
        userId, name, age, nationality, relationship, kissDate, observations, gender);
  }

  Future<List<Map<String, dynamic>>> list(int userId) async {
    return await db.list(userId);
  }

  Future<void> deleteFromList(int personId) async {
    await db.deleteFromList(personId);
  }

  Future<Map<String, dynamic>> person(int personId) async {
    return await db.person(personId);
  }

  Future<Map<String, double?>> genderStatistics(int userId) async {
    return await db.genderStatistics(userId);
  }
}
