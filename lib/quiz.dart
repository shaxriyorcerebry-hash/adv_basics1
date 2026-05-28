import 'package:adv_basic1/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:adv_basic1/start_screen.dart';
import 'package:adv_basic1/questions_screen.dart';
import 'package:adv_basic1/models/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}





class _QuizState extends State<Quiz> {
  final List<String> _selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  // YANGI FUNKSIYA — Restart
  void restartQuiz() {
    setState(() {
      _selectedAnswers.clear();
      activeScreen = 'start-screen';
    });
  }


   

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }
    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,        // <-- restart funksiyasi uzatildi
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 133, 68, 247),
                Colors.deepPurple,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}