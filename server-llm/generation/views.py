import json

from django.http import JsonResponse
from django.views import View

from generation.service import GenerationService

generation_service = GenerationService()


class GenerationSimilarQuestionView(View):
    def post(self, request, *args, **kwargs):
        body_unicode = request.body.decode('utf-8')
        body_data = json.loads(body_unicode)

        question = body_data.get('content')

        if question is None or question == "":
            return JsonResponse({
                "success": False,
                "data": None,
                "error": {
                    "message": "content가 비어있거나 없습니다.",
                    "code": 40000
                }
            }, status=400)

        return JsonResponse({
            "success": True,
            "data": {
                "result": generation_service.generate_answer_text(question)
            },
            "error": None
        }, status=200)
