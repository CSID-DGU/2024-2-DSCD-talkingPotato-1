import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/presentation/view/root/root_screen.dart';
import 'package:wooahan/presentation/view_model/board/board_binding.dart';
import 'package:wooahan/presentation/view_model/home/home_binding.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_binding.dart';
import 'package:wooahan/presentation/view_model/root/root_binding.dart';

abstract class AppPages {
  static List<GetPage> data = [
    GetPage(
      name: AppRoutes.ROOT,
      page: () => const RootScreen(),
      bindings: [
        RootBinding(),
        HomeBinding(),
        MedicationManagementBinding(),
        BoardBinding(),
      ],
    ),
  ];
}
