import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assignment_app/data/app_repository.dart';
import 'package:assignment_app/ui/quiz_screen.dart';
import 'package:assignment_app/ui/widgets/subject_item_view.dart';

import '../utils/colors.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text(
          "Quiz Apper",
            style: GoogleFonts.montserrat(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: AppColors.blue,
        )),
      ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: AppColors.cyan
            ),
            child: Center(
              child: Text(
                "Quiz it!",
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blue,
                )
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "Records",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue,
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.blue,
                      )
                    )
                  ]
                ),
                  ]
            ),
          ),
          Center(
            child: Text("Subjects", style: GoogleFonts.montserrat(
              fontSize:22,
              fontWeight: FontWeight.w400,
              color: AppColors.blue,
            )),
          ),
          for (int index = 0; index < AppRepository.subjects.length; index++)
            SubjectItemView(
              subject: AppRepository.subjects[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return QuizScreen(
                        subjectModel: AppRepository.subjects[index],
                      );
                    },
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}