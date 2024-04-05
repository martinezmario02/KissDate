import 'dart:convert';
import 'dart:io';
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
    File? image,
  ) async {
    String imagePath = '';
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      imagePath = base64Image;
    }

    await ejecutar("INSERT INTO list (user_id, name, age, nationality, relationship, kiss_date, observations, gender, image) VALUES ($userId, '$name', $age, '$nationality', '$relationship', '$kissDate', '$observations', '$gender', '$imagePath')");
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

  /// Get the number of people associated with a user.
  ///
  /// [userId] - Identifier of the user whose count is to be obtained.
  ///
  Future<int> count(int userId) async {
    List<Map<String, dynamic>> result =
        await ejecutar("select count(*) from list where user_id=$userId");
  
    return result.isNotEmpty
        ? int.tryParse(result[0]['']['count'].toString()) ?? 0
        : 0;
  }
}