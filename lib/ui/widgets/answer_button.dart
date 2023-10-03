import 'package:flutter/material.dart';
import 'package:assignment_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.isSelected,
    required this.onTap,
    required this.borderColor
  });

  final String answerText;
  final bool isSelected;
  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cyan,
        ),
            // color: isSelected ? AppColors.C_27AE60 : Colors.white),
        child: Center(
          child: Text(
            answerText,
            style: GoogleFonts.montserrat(
              fontSize: 22,
              color: AppColors.blue,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}