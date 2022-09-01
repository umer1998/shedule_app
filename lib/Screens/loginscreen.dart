import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shedule_app/Screens/homescreen.dart';
import 'package:shedule_app/Screens/profilescreen.dart';
import 'package:shedule_app/Utils/PrefConsts.dart';

import '../Utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode name_focus = FocusNode();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+## ### #######',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  FocusNode password_focus = FocusNode();
  Color focus = Colors.white.withOpacity(0.8);
  final _auth = FirebaseAuth.instance;

  late final prefs ;

  @override
  void initState(){
    super.initState();
    init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                      ),
                      color: AppColors.white,
                    ),

                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(70),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.darkOrange,
                            AppColors.darkOrange,
                          ],
                        )
                    ),


                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                      ),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 55, 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('asset/img/logo.png'), fit: BoxFit.fill),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Login",style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkOrange,
                                  fontFamily: "bold"
                              ),),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Create and manage your monthly "
                                  "schedule through this app. ",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                  fontFamily: "semibold"
                              ),),

                            ],
                          )
                        ],
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                        ),
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
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Enter Name",
                            style: TextStyle(
                                color:AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              fontFamily: "semibold"
                            ),),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: (){
                              name_focus.requestFocus();
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery. of(context). size. width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(14),
                                    topLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  border: Border.all(color: AppColors.lightGrey , width: 0.5),


                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Center(
                                  child: TextField(
                                    focusNode: name_focus,
                                    controller: nameController,

                                    style: TextStyle(
                                      fontFamily: "semibold"
                                    ),
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'email@gmail.com',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Text("Enter PhoneNo",
                            style: TextStyle(
                                color:AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              fontFamily: "regular"
                            ),),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: (){
                              password_focus.requestFocus();
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery. of(context). size. width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(14),
                                    topLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                  border: Border.all(color: AppColors.lightGrey , width: 0.5)

                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Center(
                                  child: TextField(
                                    focusNode: password_focus,
                                    controller: passwordControler,

                                    style: TextStyle(
                                        fontFamily: "semibold"
                                    ),
                                    decoration: new InputDecoration.collapsed(
                                        hintText: 'password'
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          InkWell(
                            onTap: (){
                              if(validateEmail(nameController.text)) {
                                EasyLoading.showToast('Enter valid email!');
                              } else {
                                signIn(nameController.text, passwordControler.text);
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
                                  child: Text("Submitt",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      fontFamily: "semibold"
                                    ),),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have account ? ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    fontFamily: "regular"
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                                    );
                                  },
                                  child: Text(
                                    "SignUp.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19,
                                      fontFamily: "semibold"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  bool validateEmail(String? value) {

    RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return true;
    else
      return false;
  }

  void signIn(String email, String password) async{
    EasyLoading.show(status: 'loading...');
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) =>{
    EasyLoading.dismiss(),
      prefs.setBool(PrefConsts.isLogin , true),
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()))
    }).catchError((e){
      EasyLoading.dismiss();

      Fluttertoast.showToast(msg: e!.message);
    });
  }

  Future init() async {
     prefs = await SharedPreferences.getInstance();

  }
}
