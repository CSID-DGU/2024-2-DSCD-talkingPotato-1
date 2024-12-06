import 'package:firebase_core/firebase_core.dart';

abstract class Environment {
  String get apiServerUrl;
  String get drugServerUrl;
  FirebaseOptions get firebaseOptions;
}
