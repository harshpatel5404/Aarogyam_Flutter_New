import 'package:get/get.dart';

class OrdersController extends GetxController {
  RxList pendingorderslist = [].obs;
  RxList orderslist = [].obs;
  RxList approvedorderslist = [].obs;
  RxList rejectedorderslist = [].obs;
  RxBool isOrderLoading = true.obs;
  RxBool isOrdererror = true.obs;
}
