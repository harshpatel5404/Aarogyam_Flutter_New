import 'dart:convert';
import 'dart:typed_data';

import 'package:aarogyamswadeshi/Admin/widget/drawer.dart';
import 'package:aarogyamswadeshi/Constants/constants.dart';
import 'package:aarogyamswadeshi/Screens/order/order_controller.dart';
import 'package:aarogyamswadeshi/Services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

OrdersController ordersController = Get.find();

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    getUserOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(
              "Your Orders",
              // style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: new Size(0, 50.0),
              child: TabBar(
                  indicatorColor: Colors.white,
                  controller: _controller,
                  tabs: [
                    SizedBox(height: 35, child: Text("Pending")),
                    SizedBox(height: 35, child: Text("Approved")),
                    SizedBox(height: 35, child: Text("Rejected")),
                  ]),
            ),
          ),
          body: Obx(() {
            if (ordersController.orderslist.isNotEmpty) {
              return TabBarView(controller: _controller, children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: ordersController.pendingorderslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    var order = ordersController.pendingorderslist[index];
                    String imgString = order["productimagepath"];
                    Uint8List decodedbytes = base64.decode(imgString);

                    return Container(
                      // height: Get.height * 0.1,
                      width: Get.width,
                      padding: EdgeInsets.all(15),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "OrderId : ${order['orderID']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: Get.width * 0.4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    decodedbytes,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Text(
                            "Product : ${order['productName']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Quantity : ${order['quantity']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Price : ${order['price']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   "Email : ${order['userEmail']}",
                          //   overflow: TextOverflow.ellipsis,
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: 16),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: ordersController.approvedorderslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    var order = ordersController.approvedorderslist[index];
                    String imgString = order["productimagepath"];
                    Uint8List decodedbytes = base64.decode(imgString);
                    // DateTime dateTime =
                    //     new DateFormat("yyyy-MM-dd").parse(order["createdOn"]);
                    // String date = DateFormat("yyyy-MM-dd").format(dateTime);
                    // // DateTime dateTime = DateTime.parse(order["createdOn"]);
                    // print(date);

                    return Container(
                      // height: Get.height * 0.1,
                      width: Get.width,
                      padding: EdgeInsets.all(15),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "OrderId : ${order['orderID']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: Get.width * 0.4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    decodedbytes,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Text(
                            "Product : ${order['productName']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Quantity : ${order['quantity']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Price : ${order['price']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   "Email : ${order['userEmail']}",
                          //   overflow: TextOverflow.ellipsis,
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: 16),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: ordersController.rejectedorderslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    var order = ordersController.rejectedorderslist[index];
                    String imgString = order["productimagepath"];
                    Uint8List decodedbytes = base64.decode(imgString);

                    return Container(
                      // height: Get.height * 0.1,
                      width: Get.width,
                      padding: EdgeInsets.all(15),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "OrderId : ${order['orderID']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: Get.width * 0.4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    decodedbytes,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Text(
                            "Product : ${order['productName']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Quantity : ${order['quantity']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Price : ${order['price']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   "Email : ${order['userEmail']}",
                          //   overflow: TextOverflow.ellipsis,
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(fontSize: 16),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ]);
            } else if (!ordersController.isOrderLoading.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                    child: Text(
                  "You Don't Have Any Order !",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[300], fontSize: 16),
                )),
              );
            } else if (!ordersController.isOrdererror.value) {
              return Center(
                  child: Text(
                "Somthing Went wrong, Please Try Again !",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[300], fontSize: 16),
              ));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }
          })),
    );
  }
}
