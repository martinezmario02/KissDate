import 'dart:io';
import 'package:kissdate/db/list_db.dart';

/// Instance of the database for the list of people.
ListDB db = ListDB();

/// Controller for the list of people.
class ListController {
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
  /// [image] - Image of the person.
  Future<void> addToList(
      int userId,
      String name,
      int age,
      String nationality,
      String relationship,
      DateTime kissDate,
      String observations,
      String gender,
      File? image) async {
    return await db.addToList(
        userId, name, age, nationality, relationship, kissDate, observations, gender, image);
  }

  /// Get the list of people associated with a user.
  ///
  /// [userId] - Identifier of the user whose list is to be obtained.
  Future<List<Map<String, dynamic>>> list(int userId) async {
    return await db.list(userId);
  }

  /// Delete a person from the list.
  ///
  /// [personId] - Identifier of the person to be deleted.
  Future<void> deleteFromList(int personId) async {
    await db.deleteFromList(personId);
  }

  /// Get the details of a person.
  ///
  /// [personId] - Identifier of the person whose details are to be obtained.
  Future<Map<String, dynamic>> person(int personId) async {
    return await db.person(personId);
  }

  /// Get the number of people in the list in a year.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  Future<int> countYear(int userId) async {
    return await db.countYear(userId);
  }

  /// Get the month with the most people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  Future<String> countMonth(int userId) async {
    return await db.countMonth(userId);
  }
}
