import 'package:flutter/material.dart';
import 'package:assignment_app/models/subject_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class SubjectItemView extends StatelessWidget {
  const SubjectItemView({
    super.key,
    required this.subject,
    required this.onTap,
  });

  final SubjectModel subject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cyan,
        ),
        child: Row(
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
      ),
    );
  }
}