import 'dart:convert';

import 'package:test_app/feature/data/dto/photos/photo_item.dart';
import 'package:http/http.dart' as http;

class PhotoApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PhotoItem>> getPhotos({int limit = 20}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/photos?_limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => PhotoItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching photos: $e');
    }
  }

  Future<PhotoItem> getPhoto(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/photos/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PhotoItem.fromJson(data);
      } else {
        throw Exception('Failed to load photo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching photo: $e');
    }
  }
}
