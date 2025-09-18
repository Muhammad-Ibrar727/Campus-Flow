import 'package:campus_flow/app/modules/auth/controllers/auth_controller.dart';
import 'package:campus_flow/app/routes/app_pages.dart';
import 'package:campus_flow/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(const CampusFlow());
}

class CampusFlow extends StatelessWidget {
  const CampusFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Campus Flow",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.pages,
    );
  }
}
