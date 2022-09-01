import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shedule_app/Models/createEventModel.dart';

import '../Utils/app_colors.dart';
import 'HomeScreen.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  String text = "0";
  List<DateTime>? dateTimeList = [];
  final _auth = FirebaseAuth.instance;
  List<DateTime>? dateTimeList1;
  String? color;
  String? bg;
  String startDate = DateTime.now().toString();
  String? endDate = DateTime.now().toString();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  FocusNode name_focus = FocusNode();
  FocusNode note_focus = FocusNode();
  FocusNode location_focus = FocusNode();
  Map colorMap = Map<String,Color>() ;
  List<String> listTags = [];

  @override
  void initState() {
    dateTimeList!.add(DateTime.now());
    dateTimeList!.add(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    topBar(),
                    eventName(),
                    selectStartDate(),
                eventLocation(),
                    textArea(),
                    selectColor(),
                    selectTag(),
                loginButton(),
                  ],
                ),


          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Container(
      height: 90,
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
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 18, 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: Colors.black45,
                  ),
                )),
            Text(
              "Create Event",
              style: TextStyle(
                  fontFamily: "bold", fontSize: 24, color: Colors.white),
            ),
            Container(
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget eventName(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: GestureDetector(
          onTap: (){
            name_focus.requestFocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Name",
                style: TextStyle(
                    fontFamily: "semibold",
                    fontSize: 16,
                    color: AppColors.textColor),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    border: Border.all(color: AppColors.lightGrey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
                  child: Center(
                    child: TextField(
                      focusNode: name_focus,
                      controller: eventNameController,

                    style: TextStyle(
                        fontFamily: "semibold",
                      fontSize: 16,
                      color: Colors.black
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'event name',
                      hintStyle: TextStyle(
                        color: Colors.black
                      )
                    ),
                ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget eventLocation(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: GestureDetector(
          onTap: (){
            location_focus.requestFocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Location",
                style: TextStyle(
                    fontFamily: "semibold",
                    fontSize: 16,
                    color: AppColors.textColor),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    border: Border.all(color: AppColors.lightGrey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
                  child: Center(
                    child: TextField(
                      focusNode: location_focus,
                      controller: eventLocationController,

                      style: TextStyle(
                          fontFamily: "semibold",
                          fontSize: 16,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration.collapsed(
                          hintText: 'event location',
                          hintStyle: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }


  Widget selectStartDate() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pick Start and End Date",
              style: TextStyle(
                  fontFamily: "semibold",
                  fontSize: 16,
                  color: AppColors.textColor),
            ),
            SizedBox(
              height: 7,
            ),
            InkWell(
              onTap: () {
                getDate();
                note_focus.requestFocus();
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    border: Border.all(color: AppColors.lightGrey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
                  child: Row(
                    children: [
                      Text(
                        "${text == "0" ? "pick start and end date. " : DateFormat('yyyy/MM/dd   hh:mm a').format(dateTimeList![0])}",
                        style: TextStyle(
                            fontFamily: "semibold",
                            fontSize: 16,
                            color: text == "0" ? AppColors.black : AppColors.black),
                      ),
                      Text(
                        "${text == "0" ? "" : "  to  "}",
                        style: TextStyle(
                            fontFamily: "semibold",
                            fontSize: 15,
                            color: text == "0" ? AppColors.lightGrey : AppColors.black),
                      ),
                      Text(
                        "${text == "0" ? "" : DateFormat('yyyy/MM/dd   hh:mm a').format(dateTimeList![1])}",
                        style: TextStyle(
                            fontFamily: "semibold",
                            fontSize: 16,
                            color: text == "0" ? AppColors.black : AppColors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> getDate() async {
    dateTimeList1 = await showOmniDateTimeRangePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      primaryColor: Color(0xffF5C7A9),
      backgroundColor:  Colors.white,
      calendarTextColor: AppColors.darkOrange,
      tabTextColor: Colors.black,
      unselectedTabBackgroundColor: Color(0xffF5C7A9),
      buttonTextColor: Colors.black,
      timeSpinnerTextStyle:
          const TextStyle(color: AppColors.darkOrange, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
          const TextStyle(color: AppColors.redContainer, fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime.now(),
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

    setState(() {
      dateTimeList = dateTimeList1;
      text = "sdsd";
    });
  }

  Widget textArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
      child: GestureDetector(
        onTap: (){
          note_focus.requestFocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  Note: ',
              style: TextStyle(
                  fontFamily: "semibold", fontSize: 16, color: AppColors.textColor),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    bottomLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomRight: const Radius.circular(15)),
                border: Border.all(color: AppColors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                child: TextField(
                  focusNode: note_focus,

                  controller: eventDescController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "semibold"
                  ),
                  decoration: InputDecoration.collapsed(hintText: 'Enter Note'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true, // <-- SEE HERE
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectColor() {

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  Select Color: ',
            style: TextStyle(
                fontFamily: "semibold", fontSize: 16, color: AppColors.textColor),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    color = Color(0xffD86972).toString();
                    bg = Color(0xffEEAFB4).toString();
                  });

                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: color == Color(0xffD86972).toString() ? Color(0xffD86972) : Colors.transparent//                   <--- border width here
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffD86972)),



                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    color = Color(0xff69CDCB).toString();
                    bg = Color(0xffD8F9F5).toString();
                  });

                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 1,
                        color: color == Color(0xff69CDCB).toString() ? Color(0xff69CDCB) : Colors.transparent  //                 <--- border width here
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff69CDCB)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    color = Color(0xff8879CC).toString();
                    bg = Color(0xffEEEAFF).toString();
                  });

                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 1,
                        color: color == Color(0xff8879CC).toString() ? Color(0xff8879CC) : Colors.transparent //                   <--- border width here
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff8879CC)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    color = Color(0xffB88650).toString();
                    bg = Color(0xffFEECDE).toString();
                  });

                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 1,
                        color:  color == Color(0xffB88650).toString() ? Color(0xffB88650) : Colors.transparent//                   <--- border width here
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffB88650)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectTag(){

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Tag(optional)",
            style: TextStyle(
                fontFamily: "Semibold",
                fontSize: 16,
                color: AppColors.textColor),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Gym")){
                                colorMap['Gym'] = Colors.transparent;
                                listTags.removeWhere((element) => element == "Gym");
                              } else {
                                colorMap['Gym'] = Colors.grey;
                                listTags.add("Gym");
                              }
                            });

                            },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Gym'] == null ? Colors.transparent : colorMap['Gym']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius
                                    .circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Gym", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Office")){
                                colorMap['Office'] = Colors.transparent;

                                listTags.removeWhere((element) => element == "Office");
                              } else {
                                colorMap['Office'] = Colors.grey;

                                listTags.add("Office");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Office'] == null ? Colors.transparent : colorMap['Office']//                   <--- border width here
                                ),
                                color:  Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius
                                    .circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Office", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Family")){
                                colorMap['Family'] =Colors.transparent;
                                listTags.removeWhere((element) => element == "Family");
                              } else {
                                colorMap['Family'] = Colors.grey;
                                listTags.add("Family");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Family'] == null ? Colors.transparent : colorMap['Family']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Family", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Friends")){
                                colorMap['Friends'] =Colors.transparent;

                                listTags.removeWhere((element) => element == "Friends");
                              } else {
                                colorMap['Friends'] = Colors.grey;

                                listTags.add("Friends");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Friends'] == null ? Colors.transparent : colorMap['Friends']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Friends", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Dinner")){
                                colorMap['Dinner'] =Colors.transparent;

                                listTags.removeWhere((element) => element == "Dinner");
                              } else {
                                colorMap['Dinner'] = Colors.grey;

                                listTags.add("Dinner");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Dinner'] == null ? Colors.transparent : colorMap['Dinner']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Dinner", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Meeting")){
                                colorMap['Meeting'] = Colors.transparent;

                                listTags.removeWhere((element) => element == "Meeting");
                              } else {
                                colorMap['Meeting'] = Colors.grey;

                                listTags.add("Meeting");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Meeting'] == null ? Colors.transparent : colorMap['Meeting']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius
                                    .circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Meeting", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Collegues")){
                                colorMap['Collegues'] =Colors.transparent;

                                listTags.removeWhere((element) => element == "Collegues");
                              } else {
                                colorMap['Collegues'] = Colors.grey;

                                listTags.add("Collegues");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Collegues'] == null ? Colors.transparent : colorMap['Collegues']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Collegues", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Lunch")){
                                colorMap['Lunch'] =Colors.transparent;

                                listTags.removeWhere((element) => element == "Lunch");
                              } else {
                                colorMap['Lunch'] = Colors.grey;

                                listTags.add("Lunch");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Lunch'] == null ? Colors.transparent : colorMap['Lunch']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Lunch", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            setState(() {
                              if(listTags.contains("Shopping")){
                                colorMap['Shopping'] = Colors.transparent;

                                listTags.removeWhere((element) => element == "Shopping");
                              } else {
                                colorMap['Shopping'] = Colors.grey;

                                listTags.add("Shopping");
                              }
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: colorMap['Shopping'] == null ? Colors.transparent : colorMap['Shopping']//                   <--- border width here
                                ),
                                color: Color(0xc3ededed),
                                borderRadius: new BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(10, 5, 10, 5),
                              child: Center(
                                  child: Text(
                                    "Shopping", style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "semibold",
                                      color: Colors.black
                                  ),)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Center(
      child: GestureDetector(
        onTap: (){
          setState(() {
            if (dateTimeList1![0].isBefore(dateTimeList1![1])) {
              startDate = dateTimeList1![0].toString();
              endDate = dateTimeList1![1].toString();
            } else {
              EasyLoading.showError('Start date is not greater than end date !',
                  duration: Duration(seconds: 2));

              return;
            }
          });

          
          storeEvent();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
          child: Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFF57C00),
                  Color(0xFFFFE0B2),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Submitt",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    fontFamily: "semibold"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  storeEvent() async {
    EasyLoading.show(status: 'loading...');

    String uid = _auth.currentUser!.uid.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final document = firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('events').doc();

    CreateEventModel createEventModel = CreateEventModel(eventNameController.text, startDate!, endDate!,
        eventDescController.text, color!, bg!,document.id,eventLocationController.text, listTags);


    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('events')
    .add(createEventModel.toJson()).then((value) {
      firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('events')
          .doc(value.id).update({'uid': value.id});
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
      EasyLoading.dismiss();

    });
    EasyLoading.dismiss();

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
// Color color = new Color(0x12345678);
// String colorString = color.toString(); // Color(0x12345678)
// String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
// int value = int.parse(valueString, radix: 16);
// Color otherColor = new Color(value);