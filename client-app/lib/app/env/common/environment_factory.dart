// import 'package:woowahan/app/env/common/environment.dart';
//
// abstract class EnvironmentFactory {
//   static String? _type;
//   static Environment? _environment;
//
//   static String get type => EnvironmentFactory._type!;
//   static Environment get environment => EnvironmentFactory._environment!;
//
//   static onInit() async {
//     String? flavor = await const MethodChannel('flavor').invokeMethod<String>(
//       'getFlavor',
//     );
//
//     if (flavor == null) {
//       throw Exception(
//           'Flavor is Empty. Please check your build configuration.');
//     }
//
//     switch (flavor) {
//       case 'dev':
//         _type = 'dev';
//         _environment = DevEnvironment();
//         break;
//       case 'stg':
//         _type = 'staging';
//         _environment = StagingEnvironment();
//         break;
//       case 'prod':
//         _type = 'prod';
//         _environment = ProdEnvironment();
//         break;
//       default:
//         throw Exception('Unknown flavor');
//     }
//   }
// }
