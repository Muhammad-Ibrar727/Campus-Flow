import 'package:campus_flow/app/modules/Admin/view/admin_panel.dart';
import 'package:campus_flow/app/modules/auth/views/welcome_screen.dart';
import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.HOME, page: () => const HomeView()),
    GetPage(name: AppRoutes.INITIAL, page: () => WelcomeScreen()),
    // GetPage(name: AppRoutes.STUDENT, page: () => const StudentListView()),
    GetPage(name: AppRoutes.ADMIN, page: () => AdminDashboard()),
  ];
}
