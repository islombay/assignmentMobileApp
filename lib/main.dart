import 'package:flutter/material.dart';
import 'package:assignment_app/ui/introduction_screen.dart';
import 'package:assignment_app/utils/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroductionScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.whites),
          scaffoldBackgroundColor: AppColors.whites),
    ),
  );
}