import json

from django.http import JsonResponse
from django.views import View


class GenerationSimilarQuestionView(View):
    def post(self, request, *args, **kwargs):
        body_unicode = request.body.decode('utf-8')
        body_data = json.loads(body_unicode)

        question = body_data.get('question')

        if question is None or question == "":
            # 400으로 HttpStatus를 지정한 후 JsonResponse로 응답을 보냅니다.
            return JsonResponse({
                "success": False,
                "data": None,
                "error": {
                    "message": "question은 비어있거나 존재하면 안됩니다.",
                    "code": 40000
                }
            }, status=400)

        return JsonResponse({
            "success": True,
            "data": {
                "answer": question
            },
            "error": None
        }, status=200)
