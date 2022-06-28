import 'package:flutter/cupertino.dart';
import 'package:hmm/models/dataCount.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'http://6d53-118-99-76-180.ap.ngrok.io/api';

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

getCount() async {
  final response = await http.get(Uri.parse('$_baseUrl/count'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
