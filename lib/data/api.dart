import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:anisong/utility.dart';

class Anime {
  static Future<Map?> getSearchResult(String query, String page) async {
    final url = '${JikanApi.baseUrl}${JikanApi.animeSearch}?page=$page&q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      
      if (responseData.containsKey('pagination') && responseData.containsKey('data')) {
        return responseData;
      }
      return null;
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<Map?> getThemes(String id) async {
    final url = '${JikanApi.baseUrl}${JikanApi.animeSearch}/$id{JikanApi.themes}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData.containsKey('data')) {
        Map data = responseData['data'];
        return data;
      }
      return null;
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }
}