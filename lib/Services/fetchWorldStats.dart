import 'dart:convert';

import 'package:covidtracker/Models/WorldStatModel.dart';
import 'package:covidtracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class FetchWorldStats {
  Future<WorldStatModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
