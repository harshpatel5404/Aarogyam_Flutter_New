// import 'package:aarogyamswadeshi/Constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SignupLoginScreen extends StatelessWidget {
//   SignupLoginScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Aarogyam Swadeshi",
//             style: TextStyle(
//               fontSize: 23,
//               color: kPrimaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           //  Text(
//           //   "Are You Buyer Or Seller ? ",
//           //   style: TextStyle(fontSize: 20),
//           //   textAlign: TextAlign.center,
//           // ),

//           // Image.asset(
//           //   "assets/images/buyerseller.png",
//           //   height: getProportionateScreenHeight(265),
//           //   width: getProportionateScreenWidth(235),
//           // ),
//           SizedBox(
//             height: Get.height * 0.3,
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 30),
//           //   child: SizedBox(
//           //       width: double.infinity,
//           //       height: MediaQuery.of(context).size.height * 0.07,
//           //       child: TextButton(
//           //         onPressed: () {
//           //         },
//           //         style: TextButton.styleFrom(
//           //           shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(20)),
//           //           primary: Colors.white,
//           //           backgroundColor: kPrimaryColor,
//           //         ),
//           //         child: Text(
//           //           "Buyer",
//           //           style: TextStyle(
//           //             fontSize: 18,
//           //             color: Colors.white,
//           //           ),
//           //         ),
//           //       )),
//           // ),
//           // const SizedBox(
//           //   height: 25,
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 30),
//           //   child: SizedBox(
//           //       width: double.infinity,
//           //       height: 15,
//           //       child: TextButton(
//           //         onPressed: () {
//           //         },
//           //         style: TextButton.styleFrom(
//           //           shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(20)),
//           //           primary: Colors.white,
//           //           backgroundColor: kPrimaryColor,
//           //         ),
//           //         child: Text(
//           //           "Seller",
//           //           style: TextStyle(
//           //             fontSize:15,
//           //             color: Colors.white,
//           //           ),
//           //         ),
//           //       )),
//           // ),
//           SizedBox(height: Get.height * 0.02),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             width: Get.width * 0.8,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(29),
//               child: ElevatedButton(
//                 child: Text(
//                   "LOGIN",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                     primary: kPrimaryColor,
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500)),
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             width: Get.width * 0.8,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(29),
//               child: ElevatedButton(
//                 child: Text(
//                   "SIGN UP",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                     primary: kPrimaryColor,
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:aarogyamswadeshi/Constants/constants.dart';
import 'package:aarogyamswadeshi/Screens/Signup/login_screen.dart';
import 'package:aarogyamswadeshi/Screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupLoginScreen extends StatefulWidget {
  @override
  State<SignupLoginScreen> createState() => _SignupLoginScreenState();
}

class _SignupLoginScreenState extends State<SignupLoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to\n Aarogyam Swadeshi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(500)),
              width: Get.width * 0.5,
              height: Get.width * 0.5,
            ),
            SizedBox(
                // height: Get.height * 0.4,
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
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
}
