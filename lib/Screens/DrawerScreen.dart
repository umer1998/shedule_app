import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shedule_app/Screens/homescreen.dart';
import 'package:shedule_app/Utils/app_colors.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerScreen> {
  int _selectedDestination = 0;
  var activeScreen = HomeScreen();
  final ImagePicker _picker = ImagePicker();
  late PickedFile? _imageFile = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Row(
        children: [
          Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                        image: AssetImage(
                          'asset/img/shape.png',
                        ),
                        fit: BoxFit.fill,),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("asset/img/person.png"),
                                    fit: BoxFit.fitHeight),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  // color: Color(0xffFEFEFE),
                                  width: 3,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Kasha Killingsworth",
                                    style: TextStyle(
                                        fontFamily: "semibold",
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Center(
                                  child: Image.asset(
                                    "asset/img/edit.png",
                                    color: AppColors.darkOrange,
                                    width: 17,
                                    height: 17,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Food innovator",
                              style: TextStyle(
                                  fontFamily: "regular",
                                  fontSize: 15,
                                  color: AppColors.textColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffFFB4C0),
                                            Color(0xffFE8DBC)
                                          ],
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Projects",
                                      style: TextStyle(
                                          fontFamily: "semibold",
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkOrange),
                                      child: Center(
                                        child: Text(
                                          "8",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffA4E5FF),
                                            Color(0xff56C3FE)
                                          ],
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.label_important_outline_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "The Label",
                                      style: TextStyle(
                                          fontFamily: "semibold",
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   height: 25,
                                    //   width: 25,
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: AppColors.darkOrange
                                    //   ),
                                    //   child: Center(
                                    //     child: Text("8", style: TextStyle(
                                    //         fontFamily: "regular",
                                    //         fontSize: 14,
                                    //         color: Colors.white
                                    //     ),),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffE4B3FF),
                                            Color(0xffEB8BFF)
                                          ],
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.watch_later_outlined,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "History",
                                      style: TextStyle(
                                          fontFamily: "semibold",
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   height: 25,
                                    //   width: 25,
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: AppColors.darkOrange
                                    //   ),
                                    //   child: Center(
                                    //     child: Text("8", style: TextStyle(
                                    //         fontFamily: "regular",
                                    //         fontSize: 14,
                                    //         color: Colors.white
                                    //     ),),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffFFDB91),
                                            Color(0xffFFDB91)
                                          ],
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Recycle Bin",
                                      style: TextStyle(
                                          fontFamily: "semibold",
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkOrange),
                                      child: Center(
                                        child: Text(
                                          "5",
                                          style: TextStyle(
                                              fontFamily: "regular",
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffB0F5A7),
                                            Color(0xff1FDD40)
                                          ],
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.settings,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Editor",
                                      style: TextStyle(
                                          fontFamily: "semibold",
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   height: 25,
                                    //   width: 25,
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: AppColors.darkOrange
                                    //   ),
                                    //   child: Center(
                                    //     child: Text("8", style: TextStyle(
                                    //         fontFamily: "regular",
                                    //         fontSize: 14,
                                    //         color: Colors.white
                                    //     ),),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontFamily: "semibold",
                              fontSize: 22,
                              color: AppColors.darkOrange),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
      if (_selectedDestination == 4) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const LeavesScreen()),
        // );

      }
    });
  }

  Widget imageProfile() {
    return Center(
      child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          },
          child: Center(
            child: CircleAvatar(
              radius: 34,
              backgroundImage: _imageFile == null
                  ? Image.asset(
                      "assets/img/profile.png",
                      fit: BoxFit.fill,
                    ).image
                  : FileImage(File(_imageFile!.path)),
            ),
          )
          // CircleAvatar(
          //   radius: 65.0,
          //
          //   backgroundImage: _imageFile == null
          //       ? Image.asset("assets/img/profileavatar").image
          //       : FileImage(File(_imageFile!.path)),
          // ),
          ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera, color: Colors.grey),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text(
                "Camera",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            TextButton.icon(
              icon: Icon(
                Icons.image,
                color: Colors.grey,
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text(
                "Gallery",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
      Navigator.pop(context);
    });
  }
}
