import 'package:hmm/models/dataCount.dart';
import 'package:hmm/models/dataMaintenance.dart';
import 'package:hmm/models/dataSearch.dart';
import 'package:hmm/models/dataStatistics.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://hmm.farmerestateapp.com/api';

Future<DataCount> fetchCount() async {
  final response = await http.get(Uri.parse('$_baseUrl/count'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return DataCount.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<DataMaintenance> fetchMaintenance() async {
  final response = await http.get(Uri.parse('$_baseUrl/maintenance'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DataMaintenance.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load maintenance');
  }
}

Future<DataSearch> searchData(code) async {
  final response = await http.get(Uri.parse('$_baseUrl/search/$code'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DataSearch.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to search data');
  }
}

Future<DataStatistics> fetchStatistics() async {
  final response = await http.get(Uri.parse('$_baseUrl/statistics'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DataStatistics.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to search data');
  }
}
