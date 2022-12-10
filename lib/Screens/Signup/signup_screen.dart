import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

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

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                    child: Image.asset(
                  "assets/images/logo.png",
                  height: Get.height * 0.2,
                  width: Get.width,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Name",
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
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name is Required";
                          } else
                            return null;
                        },
                      ),
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
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Phone",
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
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value.length != 10)
                            return 'Mobile Number must be of 10 digit';
                          else
                            return null;
                        },
                      ),
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
                          }
                          if (value.length <= 6) {
                            return "Password is too short!";
                          } else if (value.length >= 15) {
                            return "Password length is too long!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: kPrimaryColor,
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              }),
                          Text('English')
                        ],
                      ),
                      SizedBox(width: size.width * 0.1),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: val,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              }),
                          Text('Gujarati')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // String randomString(int length) {
                        //   var rand = new Random();
                        //   var codeUnits = new List.generate(length, (index) {
                        //     return rand.nextInt(33) + 89;
                        //   });
                        //   return String.fromCharCodes(codeUnits);
                        // }

                          EasyLoading.show(status: 'Loading...');
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          // print(nameController.text);
                          // print(phoneController.text);
                          // print(emailController.text);
                          // print(val);
                          var name = nameController.text;
                          var email = emailController.text;
                          var phone = phoneController.text;
                          var pass = passController.text;

                          Map userdata = {
                            "name": name,
                            // "phone": phone,
                            "email": email,
                            "password": pass,
                          };
                          print(userdata);
                          setUserinfo(
                              name: name,
                              email: email,
                              phone: phone,
                              password: pass,
                              lang: val);
                          // scaffoldMessage(
                          //     context, "Code has been sent to your email");
                          addUser(userdata).then((value) {
                            print(value);
                            if (value == 400) {
                              EasyLoading.showInfo("Email already used");
                              EasyLoading.dismiss();
                            } else {
                              EasyLoading.showSuccess("code sent");
                              EasyLoading.dismiss();
                              Get.to(Otp());
                            }
                          });
                        }
                        // Get.to(Otp());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
