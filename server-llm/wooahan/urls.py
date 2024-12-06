"""
URL configuration for wooahan project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from correction.views import AnalysisDocumentView, AnalysisSpeechView
from generation.views import GenerationSimilarQuestionView

urlpatterns = [
    path(
        'admin',
        admin.site.urls
    ),

    path(
        'v1/corrections/documents',
        AnalysisDocumentView.as_view(),
        name='correction-documents'
    ),

    path(
        'v1/corrections/speeches',
        AnalysisSpeechView.as_view(),
        name='correction-speeches'
    ),

    path(
        'v1/generations/similar-questions',
        GenerationSimilarQuestionView.as_view(),
        name='generation-similar-questions',
    ),
]
