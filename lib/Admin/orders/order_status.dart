import 'dart:convert';
import 'dart:typed_data';

import 'package:aarogyamswadeshi/Admin/orders/change_status.dart';
import 'package:aarogyamswadeshi/Admin/widget/drawer.dart';
import 'package:aarogyamswadeshi/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'order_status_controller.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key key}) : super(key: key);
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawerbar(),
      body: Obx(() {
        if (ordersController.orderslist.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: ordersController.orderslist.length,
            itemBuilder: (BuildContext context, int index) {
              var order = ordersController.orderslist[index];
              print(order);
              String imgString = order["productimagepath"];
              Uint8List decodedbytes = base64.decode(imgString);
              // DateTime dateTime =
              //     new DateFormat("yyyy-MM-dd").parse(order["createdOn"]);
              // String date = DateFormat("yyyy-MM-dd").format(dateTime);
              // DateTime dateTime = DateTime.parse(order["createdOn"]);
              return Container(
                // height: Get.height * 0.1,
                width: Get.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(ChangeStatus(
                                orderid: order['orderID'],
                              ));
                            },
                            child: Icon(
                              Icons.edit,
                              size: 30,
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
          );
        } else if (!ordersController.isOrdererror.value) {
          return Center(
            child: Text("Something Went Wrong!"),
          );
        } else if (!ordersController.isOrderLoading.value) {
          return Center(child: Text("Sorry ! You have not any order"));
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        }
      }),
    );
  }
}
