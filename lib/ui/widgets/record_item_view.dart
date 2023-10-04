import 'package:assignment_app/models/subject_model.dart';
import 'package:assignment_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordSubjectItem extends StatelessWidget {
  RecordSubjectItem({super.key, required this.subject, required this.maxTime, required this.maxPer});

  final SubjectModel subject;
  final int? maxTime;
  final double? maxPer;

  String formatTime(int? totalSeconds) {
    if (totalSeconds != null){
      int minutes = totalSeconds ~/ 60;
      int seconds = totalSeconds % 60;

      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondsStr = seconds.toString().padLeft(2, '0');
      return '$minutesStr:$secondsStr';
    }

    return '00:00';
  }

  late String formatedTime = formatTime(maxTime);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cyan,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                subject.iconPath,
                width: 100,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          subject.subjectName,
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue,
                          )
                      ),
                      const SizedBox(height: 5),
                      Text(
                          "Questions: ${subject.questions.length}",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue,
                          )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Percentage: ${maxPer}%",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blue,
                )
              ),
              Text(
                  "Time: ${formatedTime}",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue,
                  )
              )
            ]
          )
        ]
      )
    );
  }
}
