import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_using_api/model/quiz_model.dart';
import 'package:quiz_app_using_api/view/results_screen.dart';

class QuizController extends ChangeNotifier {
  List? questionsList;
  bool isLoading = false;
  int questionNo = 0;
  bool isCorrect = false;
  int? selectedIndex;
  bool isSelected = false;
  int results = 0;

  getData() async {
    isLoading = true;
    notifyListeners();
    final url =
        Uri.parse('https://nice-lime-hippo-wear.cyclic.app/api/v1/quiz');
    try {
      final response = await http.get(url);
      print(response.statusCode);
      final decodeData = jsonDecode(response.body);
      questionsList = decodeData.map((e) => QuizModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  checkIsSelecte(int index) {
    if (isSelected == false) {
      isCorrect = questionsList?[questionNo].options[index].isCorrect;
      selectedIndex = index;
      isSelected = true;
      notifyListeners();
    }
  }

  checkerQuestion(BuildContext context) {
    if (questionsList?[questionNo].options[selectedIndex].isCorrect == true) {
      results++;
      print("result is $results");
      notifyListeners();
    }

    if (questionNo < questionsList!.length - 1) {
      questionNo++;
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Result(
                correctA: results,
                totalQ: questionsList!.length,
              )));
    }

    selectedIndex = null;
    isSelected = false;
    notifyListeners();
  }
}
