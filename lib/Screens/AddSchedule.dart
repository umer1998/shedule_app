import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../Utils/app_colors.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  String text = "0";
  List<DateTime>? dateTimeList = [];


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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    topBar(),
                    eventName(),
                    selectStartDate(),
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
    List<DateTime>? dateTimeList1 = await showOmniDateTimeRangePicker(
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
      if (dateTimeList1![0].isBefore(dateTimeList1![1])) {
        text = "1";
        dateTimeList = dateTimeList1;
      } else {
        EasyLoading.showError('Start date is not greater than end date !',
            duration: Duration(seconds: 2));
      }
    });
    String a = "a";
  }

  Widget textArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
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
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.redContainer),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.greenContainer),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.purpleContainer),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.brownContainer),
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                      ],
                    ),
                    SizedBox(height: 9,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
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
    );
  }
}
