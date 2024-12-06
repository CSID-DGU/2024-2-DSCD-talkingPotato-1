import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/data/factory/storage_factory.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  int get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    bool isNotLogin = !StorageFactory.systemProvider.isLogin;

    if (isNotLogin) {
      return const RouteSettings(name: AppRoutes.LOGIN);
    }

    return null;
  }
}
