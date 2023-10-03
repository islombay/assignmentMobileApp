import 'package:assignment_app/ui/subjects_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment_app/models/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';


class ResultsScreen extends StatelessWidget {
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

  // math_ball = 34%
  // math_time = 23424 secs

  Future<void> setValue(double percentageOfCorrectAnswer, int timeSpendSeconds) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble("${subjectName}_ball", percentageOfCorrectAnswer); // math_ball = double for percentage
    preferences.setInt("${subjectName}_time", timeSpendSeconds);
  }

  Future<double?> getBall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? correctPercentage = preferences.getDouble("${subjectName}_ball");
    return correctPercentage;
  }

  Future<int?> getTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? timeSpend = preferences.getInt("${subjectName}_time");
    return timeSpend;
  }

  int calculateTrueAnswersCount() {
    int trueCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].trueAnswer == selectedAnswers[i]) {
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

  // int max_time = 0;
  // double max_percentage = 0;


  @override
  Widget build(BuildContext context) {
    double percentage = (100 * calculateTrueAnswersCount()) / questions.length;
    double max_per = 0;
    int max_time = -1;

    Future<void> checkAndSetRecord() async {
      bool isRecord = false;
      if (percentage >= max_per && percentage != 0) {
        if ((seconds <= max_time && max_time != -1) || max_time == -1) {
            isRecord = true;
        }
      }
      if (isRecord){
        await setValue(percentage, seconds);
      }

      print(percentage);
      print(max_per);
      print(max_time);
      print(seconds);
      print(isRecord);
    }

    Future<void> fetchData() async {
      int? value_time = await getTime();
      if (value_time != null){
        max_time = value_time;
      }
      double? value_per = await getBall();
      print(value_per);
      print("---------");
      if (value_per != null) {
        max_per = value_per;
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
                Text(formatTime(seconds),
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
                Text("${max_per}%",
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
