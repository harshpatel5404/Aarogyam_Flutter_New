import 'dart:convert';

import 'package:aarogyamswadeshi/Screens/order/order_controller.dart';
import 'package:get/get.dart';

import 'api_services.dart';
import 'pref_manager.dart';
import 'package:http/http.dart' as http;

OrdersController ordersController = Get.put(OrdersController());

Future getUserOrders() async {
  print("user order");
  var token = await getToken();
  ordersController.isOrderLoading.value = true;
  ordersController.isOrdererror.value = true;
  print(token);

  try {
    final response = await http.get(
      Uri.parse(baseUrl + "/api/Order/GetOrderIds?OrderType=All"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ordersController.orderslist.clear();
      ordersController.orderslist.value = data["data"];
      if (ordersController.orderslist.isEmpty) {
        ordersController.isOrderLoading.value = false;
      }
      print(data["data"]);
      print("order data get");
    } else {
      var data = jsonDecode(response.body);
      ordersController.isOrdererror.value = false;
      print(data);
      print("order data not get");
    }
  } catch (e) {
    ordersController.isOrdererror.value = false;
  }

  try {
    final response = await http.get(
      Uri.parse(baseUrl + "/api/Order/GetOrders?OrderType=Pending"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ordersController.pendingorderslist.clear();
      ordersController.pendingorderslist.value = data["data"];
      if (ordersController.pendingorderslist.isEmpty) {
        ordersController.isOrderLoading.value = false;
      }
      print(data["data"]);
      print("order data get");
    } else {
      var data = jsonDecode(response.body);
      ordersController.isOrdererror.value = false;
      print(data);
      print("order data not get");
    }
  } catch (e) {
    ordersController.isOrdererror.value = false;
  }
  try {
    final response = await http.get(
      Uri.parse(baseUrl + "/api/Order/GetOrders?OrderType=Rejected"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ordersController.rejectedorderslist.clear();
      ordersController.rejectedorderslist.value = data["data"];
      if (ordersController.rejectedorderslist.isEmpty) {
        ordersController.isOrderLoading.value = false;
      }
      print(data["data"]);
      print("order data get");
    } else {
      var data = jsonDecode(response.body);
      ordersController.isOrdererror.value = false;
      print(data);
      print("order data not get");
    }
  } catch (e) {
    ordersController.isOrdererror.value = false;
  }
  try {
    final response = await http.get(
      Uri.parse(baseUrl + "/api/Order/GetOrders?OrderType=Approved"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ordersController.approvedorderslist.clear();
      ordersController.approvedorderslist.value = data["data"];
      if (ordersController.approvedorderslist.isEmpty) {
        ordersController.isOrderLoading.value = false;
      }
      print(data["data"]);
      print("order data get");
    } else {
      var data = jsonDecode(response.body);
      ordersController.isOrdererror.value = false;
      print(data);
      print("order data not get");
    }
  } catch (e) {
    ordersController.isOrdererror.value = false;
  }
}
