import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:shedule_app/Screens/AddSchedule.dart';

import 'package:shedule_app/Screens/DrawerScreen.dart';
import 'package:shedule_app/Utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isShowDial = false;
  final _calendarControllerToday = AdvancedCalendarController.today();
  final List<DateTime> events = [
    DateTime.utc(2021, 08, 10, 12),
    DateTime.utc(2021, 08, 11, 12)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        drawer: DrawerScreen(),
        backgroundColor: AppColors.white,
        floatingActionButton: _getFloatingActionButton(),
        body: SafeArea(child: _getBodyWidget()),
      ),
    );
  }

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        this._isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          mini: false,
          backgroundColor: AppColors.darkOrange,
          child: Icon(Icons.menu),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: Colors.red),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(

          mini: true,
          child: Icon(Icons.delete, size: 20, color: Colors.white,),
          onPressed: () {
            //if need to close menu after click
            _isShowDial = false;
            setState(() {});
          },
          backgroundColor: Colors.red,
        ),
        FloatingActionButton(
          mini: true,
          child: Image.asset('asset/img/add.png', width: 20, height: 20, color: Colors.white,),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSchedule()),
              );
            });
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.settings, size: 20, color: Colors.white,),
          onPressed: () {

          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  Widget _getBodyWidget() {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Container(
            height: 190,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(

                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(0),
                    bottomLeft: const Radius.circular(0),
                    topRight: const Radius.circular(0),
                    bottomRight: const Radius.circular(40.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkOrange,
                    AppColors.orange,
                  ],
                )
            ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(),
                  child: topBar(),
                ),


                Container(
                  height: 120,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        textTheme: ThemeData
                            .light()
                            .textTheme
                            .copyWith(
                          subtitle1: ThemeData
                              .light()
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                          bodyText1: ThemeData
                              .light()
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          bodyText2: ThemeData
                              .light()
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            fontSize: 12,
                            color: AppColors.black,
                          ),
                        ),
                        primaryColor: AppColors.orange,
                        highlightColor: AppColors.darkOrange,
                        disabledColor: Colors.grey,
                      ),
                      child: AdvancedCalendar(
                        controller: _calendarControllerToday,
                        events: events,
                        weekLineHeight: 30.0,
                        startWeekDay: 1,

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 223.1,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: AppColors.orange,
              ),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width - 170,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40),
                      bottomLeft: const Radius.circular(0),
                      topRight: const Radius.circular(0),
                      bottomRight: const Radius.circular(0)),

                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                  child: Column(
                    children: [
                      containerDesign(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 18, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: TextStyle(
                    fontFamily: "bold", fontSize: 24, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Welcome Jack .W",
                style: TextStyle(
                    fontFamily: "regular",
                    fontSize: 18,
                    color: AppColors.white.withOpacity(0.7)),
              )
            ],
          ),

          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/img/person.png"), fit: BoxFit.fill),

              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                // color: Color(0xffFEFEFE),
                width: 1,
              ),
            ),

          )
        ],
      ),
    );
  }

  Widget containerDesign() {
    return Expanded(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                          child: Wrap(
                            children: [
                              Container(


                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFE6E7),
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      bottomLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10),
                                      bottomRight: const Radius.circular(10)),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 22, 15, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Meeting work report",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: "semibold",
                                                color: Color(0xffD86972)
                                            ),),
                                          Text(
                                            "2:00 - 2:30PM", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffD86972)
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/clock.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("1.5 Hours", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffD86972)
                                          ),),

                                          SizedBox(width: 5,),
                                          Center(child: Image.asset(
                                            "asset/img/exchange.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 13,)),
                                          SizedBox(width: 5,),
                                          Text("Weekly", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffD86972)
                                          ),),


                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/location.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("Office", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffD86972)
                                          ),),


                                        ],
                                      ),

                                      SizedBox(height: 15,),
                                      Row(
                                        children: [

                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Gym", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffD86972)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Power", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffD86972)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Snacks", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffD86972)
                                                  ),)
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,

                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF85454),

                                    ),

                                  )

                              ),
                            )

                        ),
                      ],

                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                          child: Wrap(
                            children: [
                              Container(


                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Color(0xffD8F9F5),
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      bottomLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10),
                                      bottomRight: const Radius.circular(10)),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 22, 15, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Meeting work report",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: "semibold",
                                                color: Color(0xff69CDCB)
                                            ),),
                                          Text(
                                            "2:00 - 2:30PM", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff69CDCB)
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/clock.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("1.5 Hours", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff69CDCB)
                                          ),),

                                          SizedBox(width: 5,),
                                          Center(child: Image.asset(
                                            "asset/img/exchange.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 13,)),
                                          SizedBox(width: 5,),
                                          Text("Weekly", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff69CDCB)
                                          ),),


                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/location.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("Office", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff69CDCB)
                                          ),),


                                        ],
                                      ),

                                      SizedBox(height: 15,),
                                      Row(
                                        children: [

                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Gym", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff69CDCB)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Power", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff69CDCB)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Snacks", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff69CDCB)
                                                  ),)
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,

                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff5AD1CE),

                                    ),

                                  )

                              ),
                            )

                        ),
                      ],

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                          child: Wrap(
                            children: [
                              Container(


                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Color(0xffEEEAFF),
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      bottomLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10),
                                      bottomRight: const Radius.circular(10)),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 22, 15, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Meeting work report",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: "semibold",
                                                color: Color(0xff8879CC)
                                            ),),
                                          Text(
                                            "2:00 - 2:30PM", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff8879CC)
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/clock.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("1.5 Hours", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff8879CC)
                                          ),),

                                          SizedBox(width: 5,),
                                          Center(child: Image.asset(
                                            "asset/img/exchange.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 13,)),
                                          SizedBox(width: 5,),
                                          Text("Weekly", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff8879CC)
                                          ),),


                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/location.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("Office", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xff8879CC)
                                          ),),


                                        ],
                                      ),

                                      SizedBox(height: 15,),
                                      Row(
                                        children: [

                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Gym", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff8879CC)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Power", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff8879CC)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Snacks", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xff8879CC)
                                                  ),)
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,

                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff705BCF),

                                    ),

                                  )

                              ),
                            )

                        ),
                      ],

                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                          child: Wrap(
                            children: [
                              Container(


                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Color(0xffFEECDE),
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      bottomLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10),
                                      bottomRight: const Radius.circular(10)),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 22, 15, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Meeting work report",
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontFamily: "semibold",
                                                color: Color(0xffB88650)
                                            ),),
                                          Text(
                                            "2:00 - 2:30PM", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffB88650)
                                          ),)
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/clock.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("1.5 Hours", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffB88650)
                                          ),),

                                          SizedBox(width: 5,),
                                          Center(child: Image.asset(
                                            "asset/img/exchange.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 13,)),
                                          SizedBox(width: 5,),
                                          Text("Weekly", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffB88650)
                                          ),),


                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Image.asset("asset/img/location.png",
                                            color: Color(0xffEEAFB4),
                                            width: 18,
                                            height: 18,),
                                          SizedBox(width: 8,),
                                          Text("Office", style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "regular",
                                              color: Color(0xffB88650)
                                          ),),


                                        ],
                                      ),

                                      SizedBox(height: 15,),
                                      Row(
                                        children: [

                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Gym", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffB88650)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Power", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffB88650)
                                                  ),)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),


                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10),
                                                  bottomLeft: const Radius
                                                      .circular(10),
                                                  topRight: const Radius
                                                      .circular(10),
                                                  bottomRight: const Radius
                                                      .circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(10, 5, 10, 5),
                                              child: Center(
                                                  child: Text(
                                                    "Snacks", style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "semibold",
                                                      color: Color(0xffB88650)
                                                  ),)
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,

                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffB88650),

                                    ),

                                  )

                              ),
                            )

                        ),
                      ],

                    ),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}