import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wooahan/app/env/common/environment_factory.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/main_app.dart';

void main() async {
  await onInitSystem();
  await onReadySystem();

  runApp(const MainApp());
}

Future<void> onInitSystem() async {
  // Widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  // DateTime Formatting
  await initializeDateFormatting();
  tz.initializeTimeZones();

  // Environment
  await EnvironmentFactory.onInit();

  // Storage & Database
  await StorageFactory.onInit();
}

Future<void> onReadySystem() async {
  // Storage & Database
  await StorageFactory.onReady();

  // If new download app, remove tokens
  // When token exists, isFirstRun is false
  bool isFirstRun = StorageFactory.systemProvider.getFirstRun();

  if (isFirstRun) {
    await StorageFactory.systemProvider.deallocateTokens();
    await StorageFactory.systemProvider.setFirstRun(false);
  }
}
