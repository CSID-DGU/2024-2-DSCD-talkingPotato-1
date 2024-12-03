import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/core/screen/no_implement_screen.dart';
import 'package:wooahan/presentation/view/drug/detail/drug_detail_screen.dart';
import 'package:wooahan/presentation/view/medication/adding/medication_adding_screen.dart';
import 'package:wooahan/presentation/view/medication/editing/medication_editing_screen.dart';
import 'package:wooahan/presentation/view/root/root_screen.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/speech_to_text_converter_screen.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/text_to_speech_converter_screen.dart';
import 'package:wooahan/presentation/view_model/board/board_binding.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_binding.dart';
import 'package:wooahan/presentation/view_model/home/home_binding.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_binding.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_binding.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_binding.dart';
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
        MedicationBinding(),
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
    GetPage(
      name: AppRoutes.MEDICATION,
      page: () => const NoImplementScreen(),
      children: [
        GetPage(
          name: AppRoutes.ADDING_PATH,
          page: () => const MedicationAddingScreen(),
          binding: MedicationAddingBinding(),
        ),
        GetPage(
          name: AppRoutes.EDITING_PATH,
          page: () => const MedicationEditingScreen(),
          binding: MedicationEditingBinding(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.DRUG,
      page: () => const NoImplementScreen(),
      children: [
        GetPage(
          name: AppRoutes.ID_PATH,
          page: () => const DrugDetailScreen(),
          binding: DrugDetailBinding(),
        )
      ],
    ),
  ];
}
