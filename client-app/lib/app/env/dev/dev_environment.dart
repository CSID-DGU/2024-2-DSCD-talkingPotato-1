// ignore_for_file: non_constant_identifier_names

import 'package:envied/envied.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wooahan/app/env/common/environment.dart';
import 'package:wooahan/app/env/dev/firebase_options.dart';

part 'dev_environment.g.dart';

@Envied(path: './assets/config/.dev.env')
class DevEnvironment implements Environment {
  @EnviedField(varName: 'API_SERVER_URL', defaultValue: '', obfuscate: true)
  static final String API_SERVER_URL = _DevEnvironment.API_SERVER_URL;

  @EnviedField(varName: 'DRUG_SERVER_URL', defaultValue: '', obfuscate: true)
  static final String DRUG_SERVER_URL = _DevEnvironment.DRUG_SERVER_URL;

  @override
  String get apiServerUrl => API_SERVER_URL;

  @override
  String get drugServerUrl => DRUG_SERVER_URL;

  @override
  FirebaseOptions get firebaseOptions => DefaultFirebaseOptions.currentPlatform;
}
