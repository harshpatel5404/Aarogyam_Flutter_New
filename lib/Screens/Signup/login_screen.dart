import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aarogyamswadeshi/Screens/Home/home_main.dart';
import 'package:aarogyamswadeshi/Services/admin_services.dart';
import 'package:aarogyamswadeshi/Services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:aarogyamswadeshi/Screens/Home/home_page.dart';
import 'package:aarogyamswadeshi/Screens/Signup/otp_screen.dart';
import 'package:aarogyamswadeshi/Services/pref_manager.dart';
import 'package:aarogyamswadeshi/Services/signup_service.dart';
import 'package:aarogyamswadeshi/Constants/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'background.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  // TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController passController = TextEditingController(text: "");
  bool _value = false;
  bool isVisible = false;
  int val = 1;

  Timer _timer;
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: size.height * 0.05),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                    child: Image.asset(
                  "assets/images/logo.png",
                  height: Get.height * 0.3,
                  width: Get.width,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                          cursorColor: kPrimaryColor,
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            ),
                          ),
                          validator: (email) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(email))
                              return 'Enter Valid Email';
                            else
                              return null;
                          }),
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                isVisible = !isVisible;
                                setState(() {});
                              },
                              child: isVisible
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: kPrimaryColor,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: kPrimaryColor,
                                    ),
                            )),
                        controller: passController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter the Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(height: size.height * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print("login");
                        // String randomString(int length) {
                        //   var rand = new Random();
                        //   var codeUnits = new List.generate(length, (index) {
                        //     return rand.nextInt(33) + 89;
                        //   });
                        //   return String.fromCharCodes(codeUnits);
                        // }

                        // setadminEmail(emailController.text);
                        // Get.to(Otp(
                        //   isAdmin: true,
                        // ));

                        if (formkey.currentState.validate()) {
                          EasyLoading.show(status: 'loading...');
                          formkey.currentState.save();
                          var email = emailController.text;
                          var pass = passController.text;
                          Map userdata = {
                            "email": email,
                            "password": pass,
                          };
                          print(userdata);

                          loginUser(userdata).then((value) async {
                            EasyLoading.dismiss();
                            if (value != "isadmin") {
                              scaffoldMessage(context, value);
                            }
                            if (await getlogin() == true) {
                              Get.offAll(MainScreen());
                            } else if (await getisAdmin() == true) {
                              await sendAdminverification(emailController.text)
                                  .then((value) {
                                scaffoldMessage(context, value);
                                Get.to(Otp(
                                  // isAdmin: true,
                                ));
                              });
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
