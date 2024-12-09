import json

from django.http import JsonResponse
from django.views import View

from correction.service import CorrectionService

language_service = CorrectionService()


# Create your views here.
class AnalysisDocumentView(View):
    def post(self, request, *args, **kwargs):
        document_text = None

        try:
            body_unicode = request.body.decode('utf-8')
            body_data = json.loads(body_unicode)
            document_text = body_data.get("content", "")
        except json.JSONDecodeError:
            return JsonResponse(
                data={
                    "success": False,
                    "data": None,
                    "error": {
                        "message": "Invalid JSON",
                        "code": 40000
                    }
                },
                status=400
            )

        if document_text == "":
            return JsonResponse(
                data={
                    "success": False,
                    "data": None,
                    "error": {
                        "message": "Invalid Content",
                        "code": 40000
                    }
                },
                status=400
            )

        return JsonResponse(
            data={
                "success": True,
                "data": {
                    "result": language_service.correct_document_text(document_text)
                },
                "error": None
            },
            status=200
        )


class AnalysisSpeechView(View):
    def post(self, request, *args, **kwargs):
        speech_text = None

        try:
            body_unicode = request.body.decode('utf-8')
            body_data = json.loads(body_unicode)
            speech_text = body_data.get("content", "")
        except json.JSONDecodeError:
            return JsonResponse(
                data={
                    "success": False,
                    "data": None,
                    "error": {
                        "message": "Invalid JSON",
                        "code": 40000
                    }
                },
                status=400
            )

        if speech_text == "":
            return JsonResponse(
                data={
                    "success": False,
                    "data": None,
                    "error": {
                        "message": "Invalid content",
                        "code": 40000
                    }
                },
                status=400
            )

        return JsonResponse(
            data={
                "success": True,
                "data": {
                    "result": language_service.correct_speech_text(speech_text)
                },
                "error": None
            },
            status=200
        )
