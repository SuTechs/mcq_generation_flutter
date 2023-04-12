import 'package:mcq_generation_flutter/data/data/dummy_response.dart';

import '../data/data.dart';

Future<List<QuestionData>> getQuestionData() {
  List<QuestionData> dataList = [];

  for (var element in kDummyResponse) {
    final qData = QuestionData.fromJson(element);
    dataList.add(qData);
  }

  return Future.delayed(const Duration(milliseconds: 3000))
      .then((value) => dataList);
}
