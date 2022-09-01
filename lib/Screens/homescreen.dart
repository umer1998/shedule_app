
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shedule_app/Models/createEventModel.dart';
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
  final _auth = FirebaseAuth.instance;
  final _calendarControllerToday = AdvancedCalendarController.today();
  final List<DateTime> events = [
    DateTime.utc(2021, 08, 10, 12),
    DateTime.utc(2021, 08, 11, 12)
  ];

  late CreateEventModel createEventModel;
  String uid = "";
  String data = "";
  bool _isDropped = false;
  List<CreateEventModel> listEvents = [];

  late final prefs;
  bool dragableEnable = false;
  bool insideTarget = false;


  @override
  void initState() {
    super.initState();
    init();
    getEvents();
  }


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
          child: Image.asset(
            'asset/img/add.png', width: 20, height: 20, color: Colors.white,),
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

    return Stack(
      children: [
        Column(
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

        DragTarget<String>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Visibility(
              visible: dragableEnable,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                      shape: BoxShape.circle
                    ),
                    child: Center(child: Icon(Icons.delete, color: Colors.white,),),
                  ),
                ),
              ),
            );
          },

          onAccept: (String data1) {
            print (data1);
            setState(() {
              EasyLoading.show(status: 'loading...');
              FirebaseFirestore.instance.collection(
                  'users').doc(_auth.currentUser!.uid).collection("events").doc(uid).delete().then((value) =>
                  print("deleted")).catchError((e){
                    print(e.toString());
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
              );
              EasyLoading.dismiss();
              EasyLoading.show(status: 'Moved to Recycle Bin.' , );
              _isDropped = true;
            });


          },
          onLeave: (data) {
            print("missed");
            setState(() {
              dragableEnable =false;
            });
          },
        ),

      ],
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
      child: Container(

        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: listEvents == null ? 0 : listEvents!.length,
          itemBuilder: (context, index) {
            String valueString = listEvents[index].colors!.split('(0x')[1]
                .split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color color = new Color(value);

            String valueString1 = listEvents[index].bg!.split('(0x')[1].split(
                ')')[0]; // kind of hacky..
            Color colorbg = new Color(int.parse(valueString1, radix: 16));


            String startHours = DateFormat('hh:mm').format(
                DateTime.parse(listEvents[index].startDate!));
            String endhours = DateFormat('hh:mm a').format(
                DateTime.parse(listEvents[index].endDate!));


            String hours = startHours + " : " + endhours;

            var differenceHours = DateTime
                .parse(listEvents[index].endDate!)
                .difference(DateTime.parse(listEvents[index].startDate!))
                .inHours;
            var differenceHours1 = DateTime
                .parse(listEvents[index].endDate!)
                .difference(DateTime.parse(listEvents[index].startDate!))
                .inMinutes;

            String diff = differenceHours.toString() + ":" +
                (differenceHours1 % 60).toString() + " Hours";

            return Column(
              children: [
                Draggable<String>(
                  data: 'red',
                  onDragStarted: (){
                    setState(() {
                      uid = listEvents[index].uid!;
                      createEventModel = listEvents[index];
                      dragableEnable = true;
                    });

                  },

                  feedback:Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: InkWell(
                      onTap: (){
                        // FirebaseFirestore.instance.collection(
                        //     'users').doc(_auth.currentUser!.uid).collection("events").doc(listEvents[index].uid).delete().then((value) =>
                        //     print("deleted")).catchError((e){
                        //   print(e.toString());
                        // });
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomeScreen()),
                        //       (Route<dynamic> route) => false,
                        // );
                      },
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
                                      color: colorbg.withOpacity(0.4),
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
                                              Text("${listEvents[index].eventName}",
                                                style: TextStyle(
                                                  fontSize: 21,
                                                  fontFamily: "semibold",
                                                  color: color,
                                                ),),
                                              Text(
                                                "${hours}", style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "regular",
                                                color: color,
                                              ),)
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              Image.asset("asset/img/clock.png",
                                                color: color,
                                                width: 18,
                                                height: 18,),
                                              SizedBox(width: 8,),
                                              Text("${diff} ", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
                                              ),),

                                              SizedBox(width: 5,),
                                              Center(child: Image.asset(
                                                "asset/img/exchange.png",
                                                color: color,
                                                width: 18,
                                                height: 13,)),
                                              SizedBox(width: 5,),
                                              Text("Once", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
                                              ),),


                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              Image.asset("asset/img/location.png",
                                                color: color,
                                                width: 18,
                                                height: 18,),
                                              SizedBox(width: 8,),
                                              Text("Office", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
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
                                                          color: color
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
                                                          color: color
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
                                                          color: color
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
                                            color: color
                                        ),

                                      )

                                  ),
                                )

                            ),
                          ],

                        ),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: InkWell(
                      onTap: (){

                      },
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
                                      color: colorbg,
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
                                              Text("${listEvents[index].eventName}",
                                                style: TextStyle(
                                                  fontSize: 21,
                                                  fontFamily: "semibold",
                                                  color: color,
                                                ),),
                                              Text(
                                                "${hours}", style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "regular",
                                                color: color,
                                              ),)
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              Image.asset("asset/img/clock.png",
                                                color: color,
                                                width: 18,
                                                height: 18,),
                                              SizedBox(width: 8,),
                                              Text("${diff} ", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
                                              ),),

                                              SizedBox(width: 5,),
                                              Center(child: Image.asset(
                                                "asset/img/exchange.png",
                                                color: color,
                                                width: 18,
                                                height: 13,)),
                                              SizedBox(width: 5,),
                                              Text("Once", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
                                              ),),


                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              Image.asset("asset/img/location.png",
                                                color: color,
                                                width: 18,
                                                height: 18,),
                                              SizedBox(width: 8,),
                                              Text("Office", style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "regular",
                                                  color: color
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
                                                          color: color
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
                                                          color: color
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
                                                          color: color
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
                                            color: color
                                        ),

                                      )

                                  ),
                                )

                            ),
                          ],

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }


  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<CreateEventModel>> getEventData() async {
    EasyLoading.show(status: 'loading...');

    List<CreateEventModel> model = [];
    String uid = _auth.currentUser!.uid.toString();
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
        'users').doc(uid).collection("events");

    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) =>
        CreateEventModel(
            doc['eventName'].toString(),
            doc['startDate'],
            doc['endDate'],
            doc['description'],
            doc['colors'],
            doc['bg'],
            doc['uid'],
            doc['location'],

            List<String>.from(doc['tags'])
        )).toList();
    EasyLoading.dismiss();

    return allData;
  }

  void getEvents() async {
    listEvents = await getEventData();
    setState(() {});
  }

}