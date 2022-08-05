import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shedule_app/Models/UserModel.dart';
import 'package:shedule_app/Screens/homescreen.dart';
import 'package:shedule_app/Screens/loginscreen.dart';
import 'package:shedule_app/Utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  late PickedFile? _imageFile = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController professionControler = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Timer? _timer;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+## ### #######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  FocusNode name_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  FocusNode phone_focus = FocusNode();
  FocusNode profession_focus = FocusNode();
  FocusNode password_focus = FocusNode();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,

            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: "bold"),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                    child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25)),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 95, 25, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter Name",
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "semibold"),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    name_focus.requestFocus();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          topLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrey,
                                            width: 0.5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Center(
                                        child: TextField(
                                          focusNode: name_focus,
                                          controller: nameController,
                                          style: TextStyle(fontFamily: "regular"),
                                          decoration:
                                          new InputDecoration.collapsed(
                                              hintText: 'Username'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  "Enter PhoneNo",
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "semibold"),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    phone_focus.requestFocus();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          topLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrey,
                                            width: 0.5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Center(
                                        child: TextField(
                                          focusNode: phone_focus,
                                          controller: phoneControler,
                                          style: TextStyle(fontFamily: "regular"),
                                          inputFormatters: [maskFormatter],
                                          decoration:
                                          new InputDecoration.collapsed(
                                              hintText: '+92 333 1234567'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  "Enter Email",
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "semibold"),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    email_focus.requestFocus();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          topLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrey,
                                            width: 0.5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Center(
                                        child: TextField(
                                          focusNode: email_focus,
                                          controller: emailController,
                                          style: TextStyle(fontFamily: "regular"),
                                          decoration:
                                          new InputDecoration.collapsed(
                                              hintText: 'email@gmail.com'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  "Enter Password",
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "semibold"),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    password_focus.requestFocus();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          topLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrey,
                                            width: 0.5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Center(
                                        child: TextField(
                                          obscureText: true,
                                          focusNode: password_focus,
                                          controller: passwordController,
                                          style: TextStyle(fontFamily: "regular"),
                                          decoration:
                                          new InputDecoration.collapsed(
                                              hintText: 'password'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  "Enter Profession",
                                  style: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "semibold"),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    profession_focus.requestFocus();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(14),
                                          topLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrey,
                                            width: 0.5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Center(
                                        child: TextField(
                                          focusNode: profession_focus,
                                          controller: professionControler,
                                          style: TextStyle(fontFamily: "regular"),
                                          decoration:
                                          new InputDecoration.collapsed(
                                              hintText: 'Student'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (validateEmail(emailController.text)) {
                                      EasyLoading.showToast('Enter valid email!');
                                    } else {
                                      register(emailController.text, passwordController.text);
                                    }
                                  },
                                  child: Align(
                                    alignment: Alignment.topCenter,
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
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have account ? ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: "regular"),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const LoginScreen()),
                                            );
                                          },
                                          child: Text(
                                            "Login.",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                                fontFamily: "semibold"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                     
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: imageProfile(),
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffdc6020), width: 3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: _imageFile == null
                        ? Image.asset(
                            "asset/img/user.png",
                            fit: BoxFit.fill,
                          ).image
                        : FileImage(File(_imageFile!.path)),
                  ),
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
        ));
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

  bool validateEmail(String? value) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return true;
    else
      return false;
  }

  void register(String email, String password) async {
    EasyLoading.show(status: 'loading...');
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              postDetailToFireStore(),
            })
        .catchError((e) {

    });
  }

  postDetailToFireStore() async {
    //calling firestore
    //calling user model
    //send these values to firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.profession = professionControler.text;
    userModel.name = nameController.text;
    userModel.email = emailController.text;
    userModel.phoneno = phoneControler.text;
    userModel.image = "";
    userModel.uid = user!.uid;

    await firebaseFirestore
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toMap());

    EasyLoading.dismiss();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
