import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/core/screen/no_implement_screen.dart';
import 'package:wooahan/presentation/view/article/default/article_screen.dart';
import 'package:wooahan/presentation/view/article/detail/article_detail_screen.dart';
import 'package:wooahan/presentation/view/article/searching/article_searching_screen.dart';
import 'package:wooahan/presentation/view/comment_writing/comment_writing_screen.dart';
import 'package:wooahan/presentation/view/drug/detail/drug_detail_screen.dart';
import 'package:wooahan/presentation/view/medication/adding/medication_adding_screen.dart';
import 'package:wooahan/presentation/view/medication/editing/medication_editing_screen.dart';
import 'package:wooahan/presentation/view/question/adding/question_adding_screen.dart';
import 'package:wooahan/presentation/view/question/default/question_screen.dart';
import 'package:wooahan/presentation/view/question/detail/question_detail_screen.dart';
import 'package:wooahan/presentation/view/question/searching/question_searching_screen.dart';
import 'package:wooahan/presentation/view/root/root_screen.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/speech_to_text_converter_screen.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/text_to_speech_converter_screen.dart';
import 'package:wooahan/presentation/view_model/article/default/article_binding.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_binding.dart';
import 'package:wooahan/presentation/view_model/article/searching/article_searching_binding.dart';
import 'package:wooahan/presentation/view_model/board/board_binding.dart';
import 'package:wooahan/presentation/view_model/comment_writing/comment_writing_binding.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_binding.dart';
import 'package:wooahan/presentation/view_model/home/home_binding.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_binding.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_binding.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_binding.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_binding.dart';
import 'package:wooahan/presentation/view_model/question/default/question_binding.dart';
import 'package:wooahan/presentation/view_model/question/detail/question_detail_binding.dart';
import 'package:wooahan/presentation/view_model/question/searching/question_searching_binding.dart';
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
      name: AppRoutes.ARTICLE,
      page: () => const ArticleScreen(),
      binding: ArticleBinding(),
      children: [
        GetPage(
          name: AppRoutes.SEARCHING_PATH,
          page: () => const ArticleSearchingScreen(),
          binding: ArticleSearchingBinding(),
        ),
        GetPage(
          name: AppRoutes.ID_PATH,
          page: () => const ArticleDetailScreen(),
          binding: ArticleDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.QUESTION,
      page: () => const QuestionScreen(),
      binding: QuestionBinding(),
      children: [
        GetPage(
          name: AppRoutes.ADDING_PATH,
          page: () => const QuestionAddingScreen(),
          binding: QuestionAddingBinding(),
        ),
        GetPage(
          name: AppRoutes.SEARCHING_PATH,
          page: () => const QuestionSearchingScreen(),
          binding: QuestionSearchingBinding(),
        ),
        GetPage(
          name: AppRoutes.ID_PATH,
          page: () => const QuestionDetailScreen(),
          binding: QuestionDetailBinding(),
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
    GetPage(
      name: AppRoutes.COMMENT_WRITING,
      page: () => const CommentWritingScreen(),
      binding: CommentWritingBinding(),
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
