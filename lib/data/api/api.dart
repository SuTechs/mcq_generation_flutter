import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';

class Api {
  static final _url = Uri.http('localhost:5000', 'generate_question');

  static Future<List<QuestionData>> getQuestionData(
      String courseContent) async {
    List<QuestionData> dataList = [];

    try {
      final data = await _callApi(courseContent);

      if (data != null) {
        for (final element in data) {
          final qData = QuestionData.fromJson(element);
          dataList.add(qData);
        }
      }
    } catch (e) {
      debugPrint('Error while calling API = $e');
    }

    return dataList;
  }

  static Future<List<Map<String, dynamic>>?> _callApi(String text) async {
    final data = jsonEncode({"text": text});
    // final data = jsonEncode({"text": "What is computer Network?"});
    final response = await http
        .post(_url, body: data, headers: {'Content-Type': 'application/json'});

    debugPrint('hello ${response.body}');

    if (response.statusCode != 200) return null;

    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }
}
