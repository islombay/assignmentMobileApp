import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assignment_app/models/question_model.dart';
import 'package:assignment_app/models/subject_model.dart';
import 'package:assignment_app/ui/results_screen.dart';
import 'package:assignment_app/ui/widgets/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.subjectModel,
  });

  final SubjectModel subjectModel;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int selectedQuestionOrder = -1;
  Map<int, int> selectedAnswers = {};
  List<QuestionModel> questions = [];
  Color _btnBorderColor = AppColors.cyan;

  int seconds = 0;
  late Timer timer;

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }


  @override
  void initState() {
    questions = widget.subjectModel.questions;
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer)
    {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
            widget.subjectModel.subjectName, style: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.blue,
        ))),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Timer:", style: GoogleFonts.montserrat(
                  fontSize:24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                )),
                Text(formatTime(seconds), style: GoogleFonts.montserrat(
                  fontSize:24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.pink,
                )),
              ]
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Center(
                    child: Text(
                      questions[currentQuestionIndex].questionText,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whites,
                      )
                    ),
                  )
                ),
                const SizedBox(height: 20),
                AnswerButton(
                  answerText: questions[currentQuestionIndex].answer1,
                  isSelected: selectedQuestionOrder == 1,
                  borderColor: _btnBorderColor,
                  onTap: () {
                    setState(() {
                      selectedQuestionOrder = 1;
                      selectedAnswers[currentQuestionIndex] =
                          selectedQuestionOrder;
                    });
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                      selectedQuestionOrder = -1;
                      setState(() {});
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResultsScreen(
                              questions: questions,
                              selectedAnswers: selectedAnswers,
                              subjectName: widget.subjectModel.subjectShortName,
                              seconds: seconds,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                AnswerButton(
                  answerText: questions[currentQuestionIndex].answer2,
                  isSelected: selectedQuestionOrder == 2,
                  borderColor: _btnBorderColor,
                  onTap: () {

                    setState(() {
                      selectedQuestionOrder = 2;
                      selectedAnswers[currentQuestionIndex] =
                          selectedQuestionOrder;
                    });
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                      selectedQuestionOrder = -1;
                      setState(() {});
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResultsScreen(
                              questions: questions,
                              selectedAnswers: selectedAnswers,
                              seconds: seconds,
                              subjectName: widget.subjectModel.subjectShortName,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                AnswerButton(
                  answerText: questions[currentQuestionIndex].answer3,
                  isSelected: selectedQuestionOrder == 3,
                  borderColor: _btnBorderColor,
                  onTap: () {

                    setState(() {
                      selectedQuestionOrder = 3;
                      selectedAnswers[currentQuestionIndex] =
                          selectedQuestionOrder;
                    });
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                      selectedQuestionOrder = -1;
                      setState(() {});
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResultsScreen(
                              questions: questions,
                              selectedAnswers: selectedAnswers,
                              seconds: seconds,
                              subjectName: widget.subjectModel.subjectShortName,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                AnswerButton(
                  answerText: questions[currentQuestionIndex].answer4,
                  isSelected: selectedQuestionOrder == 4,
                  borderColor: _btnBorderColor,
                  onTap: () {
                    setState(() {
                      selectedQuestionOrder = 4;
                      selectedAnswers[currentQuestionIndex] =
                          selectedQuestionOrder;
                    });
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                      selectedQuestionOrder = -1;
                      setState(() {});
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResultsScreen(
                              questions: questions,
                              selectedAnswers: selectedAnswers,
                              seconds: seconds,
                              subjectName: widget.subjectModel.subjectShortName,
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     if (currentQuestionIndex < questions.length - 1) {
          //       currentQuestionIndex++;
          //       selectedQuestionOrder = -1;
          //       setState(() {});
          //     } else {
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return ResultsScreen(
          //               questions: questions,
          //               selectedAnswers: selectedAnswers,
          //             );
          //           },
          //         ),
          //       );
          //     }
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         ((currentQuestionIndex) == questions.length - 1)
          //             ? "RESULT"
          //             : "NEXT",
          //       ),
          //       const SizedBox(width: 12),
          //       const Icon(Icons.arrow_forward)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}