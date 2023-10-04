import 'package:assignment_app/ui/subjects_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment_app/models/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';


class ResultsScreen extends StatefulWidget {
  ResultsScreen(
      {super.key,
        required this.questions,
        required this.selectedAnswers,
        required this.subjectName,
        required this.seconds});

  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers;
  final String subjectName;
  final int seconds;

  late int max_time = 0;
  late double max_per = 0;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  Future<void> setValue(double percentageOfCorrectAnswer, int timeSpendSeconds) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble("${widget.subjectName}_ball", percentageOfCorrectAnswer); // math_ball = double for percentage
    preferences.setInt("${widget.subjectName}_time", timeSpendSeconds);
  }

  Future<double?> getBall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? correctPercentage = preferences.getDouble("${widget.subjectName}_ball");
    return correctPercentage;
  }

  Future<int?> getTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? timeSpend = preferences.getInt("${widget.subjectName}_time");
    return timeSpend;
  }

  int calculateTrueAnswersCount() {
    int trueCount = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (widget.questions[i].trueAnswer == widget.selectedAnswers[i]) {
        trueCount++;
      }
    }
    return trueCount;
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (100 * calculateTrueAnswersCount()) / widget.questions.length;
    // double max_per = 0;
    // int max_time = -1;

    Future<void> checkAndSetRecord() async {
      bool isRecord = false;
      // if (percentage >= widget.max_per && percentage != 0) {
      //   if ((widget.seconds <= widget.max_time && widget.max_time != -1) || widget.max_time == -1) {
      //     isRecord = true;
      //   }
      // }
      if (percentage != 0){
        if (widget.max_time == 0 || (percentage == widget.max_per && widget.seconds <= widget.max_time)){
          isRecord = true;
        } else if (percentage > widget.max_per) {
          isRecord = true;
        }
      }
      if (isRecord){
        await setValue(percentage, widget.seconds);
      }
      setState((){});
    }

    Future<void> fetchData() async {
      int? value_time = await getTime();
      if (value_time != null){
        widget.max_time = value_time;
      }
      double? value_per = await getBall();
      if (value_per != null) {
        widget.max_per = value_per;
      }
      await checkAndSetRecord();
    }
    fetchData();



    Color resColor = AppColors.pink;
    Color resTextColor = AppColors.blue;
    String resText = "Bad!";
    if (percentage < 86 && percentage >= 60) {
      resColor = AppColors.blue;
      resText = "Good";
      resTextColor = AppColors.whites;
    }
    if (percentage >= 86) {
      resColor = AppColors.cyan;
      resText = "Great!";
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text("Results",
                style: GoogleFonts.montserrat(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                ))),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("You found ${percentage}% answers",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    color: resColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(resText,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: resTextColor,
                      )),
                )),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Time spent:",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue,
                    )),
                Text(formatTime(widget.seconds),
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pink,
                    ))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Last Record:",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue,
                    )),
                Text("${widget.max_per}%",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ))
              ]),
              const SizedBox(),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectsScreen()),
                            );
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                color: AppColors.cyan,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                  child: Text("Menu",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blue,
                                      )
                                  )
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}