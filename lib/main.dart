import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_using_api/controller/quiz_controller.dart';
import 'package:quiz_app_using_api/view/question_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuizController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QuestionPage(),
      ),
    );
  }
}
