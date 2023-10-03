import 'package:flutter/material.dart';
import 'package:assignment_app/models/question_model.dart';

class SubjectModel {
  SubjectModel({
    required this.subjectName,
    required this.questions,
    required this.iconPath,
    required this.subjectShortName,
  });

  final String subjectName;
  final String iconPath;
  final List<QuestionModel> questions;
  final String subjectShortName;
}
