import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../Utils/app_colors.dart';


class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {

  String? text;
  List<DateTime>? dateTimeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(),
         child: Column(
           children: [
             topBar(),
             selectStartDate(),
             selectEndDate()
           ],
         ),
       ),
      ),
    );
  }

  Widget topBar() {
    return Container(
      height:90,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(0),
              bottomLeft: const Radius.circular(20),
              topRight: const Radius.circular(0),
              bottomRight: const Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkOrange,
              AppColors.orange,
            ],
          )
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 18, 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Align( alignment: Alignment.topLeft, child: Icon(Icons.arrow_back_ios_outlined, size: 20, color: Colors.black45,)),
            Text(
              "Create Event",
              style: TextStyle(
                  fontFamily: "bold", fontSize: 24, color: Colors.white),
            ),
            Container(height: 20,
            width: 20,)

          ],
        ),
      ),
    );
  }

  Widget selectStartDate(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: InkWell(
        onTap: (){
         setState(()  async {
          getDate();
         });


        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                topLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              border: Border.all(color: AppColors.lightGrey , width: 0.5)
          ),
          child: Column(
            children: [
              Text("Pick Date", style: TextStyle(
                  fontFamily: "regular",
                  fontSize: 16,
                  color: AppColors.textColor
              ),),
              SizedBox(height: 7,),
              Text("${text![0] == "" ? "Pick Text" : text}", style: TextStyle(
                  fontFamily: "semibold",
                  fontSize: 18,
                  color: AppColors.darkOrange
              ),)
            ],
          ),
        ),
      )
    );
  }

  Widget selectEndDate(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: InkWell(
          // onTap: (){
          //   setState(()  async {
          //     getDate();
          //   });
          //
          //
          // },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                border: Border.all(color: AppColors.lightGrey , width: 0.5)
            ),
            child: Column(
              children: [
                Text("Pick Date", style: TextStyle(
                    fontFamily: "regular",
                    fontSize: 16,
                    color: AppColors.textColor
                ),),
                SizedBox(height: 7,),
                Text("${text![1] == "" ? "Pick Text" : text}", style: TextStyle(
                    fontFamily: "semibold",
                    fontSize: 18,
                    color: AppColors.darkOrange
                ),)
              ],
            ),
          ),
        )
    );
  }

  Future<void> getDate() async {
    dateTimeList =  await showOmniDateTimeRangePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      primaryColor: Colors.cyan,
      backgroundColor: Colors.grey[900],
      calendarTextColor: Colors.white,
      tabTextColor: Colors.white,
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: Colors.white,
      timeSpinnerTextStyle:
      const TextStyle(color: Colors.white70, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
      const TextStyle(color: Colors.white, fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate:
      DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      borderRadius: const Radius.circular(16),
    );


  }
}
