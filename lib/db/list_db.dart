import 'db.dart';

/// Class that represents the database for the list.
class ListDB extends DB {
  /// Add a person to the list.
  ///
  /// [userId] - Identifier of the user to whom the person is associated.
  /// [name] - Name of the person.
  /// [age] - Age of the person
  /// [nationality] - Nationality of the person.
  /// [relationship] - Relationship with the person.
  /// [kissDate] - Date of the first kiss with the person.
  /// [observations] - Observations about the person.
  /// [gender] - Gender of the person.
  Future<List<Map<String, dynamic>>> addToList(
      int userId,
      String name,
      int age,
      String nationality,
      String relationship,
      DateTime kissDate,
      String observations,
      String gender) async {
    return await ejecutar(
        "insert into list (user_id, name, age, nationality, relationship, kiss_date, observations, gender) values ($userId, '$name', $age, '$nationality', '$relationship', '$kissDate', '$observations', '$gender')");
  }

  /// Returns the list of people associated with a user.
  ///
  /// [userId] - Identifier of the user whose list is to be obtained.
  Future<List<Map<String, dynamic>>> list(int userId) async {
    return await ejecutar("select * from list where user_id=$userId");
  }

  /// Delete a person from the list.
  ///
  /// [personId] - Identifier of the person to be deleted.
  Future<void> deleteFromList(int personId) async {
    await ejecutar("delete from list where person_id=$personId");
  }

  /// Get the details of a person.
  ///
  /// [personId] - Identifier of the person whose details are to be obtained.
  Future<Map<String, dynamic>> person(int personId) async {
    List<Map<String, dynamic>> result =
        await ejecutar("select * from list where person_id=$personId");
    return result.isNotEmpty
        ? result[0]
        : {};
  }
}