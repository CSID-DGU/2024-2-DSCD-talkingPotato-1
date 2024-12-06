import 'package:wooahan/app/env/common/environment.dart';
import 'package:wooahan/app/env/dev/dev_environment.dart';

abstract class EnvironmentFactory {
  static String? _type;
  static Environment? _environment;

  static String get type => _type!;
  static Environment get environment => _environment!;

  static Future<void> onInit() async {
    _type = 'dev';
    _environment = DevEnvironment();
  }
}
