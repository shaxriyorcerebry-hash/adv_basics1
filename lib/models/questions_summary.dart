import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator(); // <-- Stretch effektini to'xtatadi
          return true;
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), // <-- Overscrollni cheklaydi
          child: Column(
            children: summaryData.map((data) {
              final bool isCorrect = data['user_answer'] == data['correct_answer'];

              final Color circleColor = isCorrect
                  ? const Color.fromARGB(255, 78, 102, 241)
                  : const Color.fromARGB(255, 239, 82, 122);

              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          ((data['question_index'] as int) + 1).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['question'] as String,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Your answer: ${data['user_answer']}",
                            style: GoogleFonts.lato(
                              color: isCorrect
                                  ? const Color.fromARGB(255, 21, 255, 0)
                                  : const Color.fromARGB(255, 255, 1, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Correct answer: ${data['correct_answer']}",
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 128, 193, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}