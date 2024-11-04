import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/presentation/speech_to_text_converter/speech_to_text_converter_screen.dart';
import 'package:wooahan/presentation/text_to_speech_converter/text_to_speech_converter_screen.dart';
import 'package:wooahan/presentation/view/root/root_screen.dart';
import 'package:wooahan/presentation/view_model/board/board_binding.dart';
import 'package:wooahan/presentation/view_model/home/home_binding.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_binding.dart';
import 'package:wooahan/presentation/view_model/root/root_binding.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_binding.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_binding.dart';

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
    GetPage(
      name: AppRoutes.TEXT_TO_SPEECH_CONVERTER,
      page: () => const TextToSpeechConverterScreen(),
      binding: TextToSpeechConverterBinding(),
    ),
    GetPage(
      name: AppRoutes.SPEECH_TO_TEXT_CONVERTER,
      page: () => const SpeechToTextConverterScreen(),
      binding: SpeechToTextConverterBinding(),
    ),
  ];
}
