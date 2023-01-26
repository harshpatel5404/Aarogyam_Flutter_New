import 'package:permission_handler/permission_handler.dart';

Future getPermission() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();
  }
}
