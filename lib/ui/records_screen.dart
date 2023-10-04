import 'package:assignment_app/ui/subjects_screen.dart';
import 'package:assignment_app/ui/widgets/record_item_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subject_model.dart';
import '../utils/colors.dart';

class RecordsScreen extends StatefulWidget {
  RecordsScreen({super.key, required this.subjects});

  final List<SubjectModel> subjects;

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {

  Future<double?> getBall(String shortName) async {
    print(shortName);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? correctPercentage = preferences.getDouble("${shortName}_ball");
    return correctPercentage;
  }

  Future<int?> getTime(String shortName) async {
    print(shortName);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? timeSpend = preferences.getInt("${shortName}_time");
    return timeSpend;
  }

  late Map<String, double> records_list_percentage = {};
  late Map<String, int> records_list_time = {};

  Future<void> fetchData() async {
    for(int index=0; index < widget.subjects.length; index++){
      String shortName = widget.subjects[index].subjectShortName;
      int? timeRecord = await getTime(shortName);
      double? percentageRecord = await getBall(shortName);

      print(timeRecord);
      print(percentageRecord);
      print("\n");

      percentageRecord ??= 0;
      timeRecord ??= 0;

      records_list_percentage["${shortName}_ball"] = percentageRecord;
      records_list_time["${shortName}_time"] = timeRecord;

      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
          title: Center(
            child: Text(
              "Records",
              style: GoogleFonts.montserrat(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              )
            )
          ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              for (int index = 0; index < widget.subjects.length; index++)
                RecordSubjectItem(
                  subject: widget.subjects[index],
                  maxTime: records_list_time["${widget.subjects[index].subjectShortName}_time"],
                  maxPer: records_list_percentage["${widget.subjects[index].subjectShortName}_ball"],
                ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubjectsScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
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
              )
            ],
          ),
        ],
      )
    );
  }
}
