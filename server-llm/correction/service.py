from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from langchain_openai import ChatOpenAI


class CorrectionService:
    def __init__(self):
        self.llm = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)

        self._speech_correction_prompt = ChatPromptTemplate.from_messages([
            SystemMessagePromptTemplate.from_template(
                """
                You are a professional AI assistant specialized in speech text correction. 
                You must perfectly understand the linguistic characteristics of Korean speakers, 
                accurately capture context and intent, and correct text into natural Korean.
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                - Consider grammar, vocabulary, and context comprehensively during correction.
                - Use expressions easily understood by Korean speakers aged 50-60.
                - Apply appropriate honorifics and formal language.
                - Absolutely do not add any additional information or sentences beyond the corrected content.
                """
            ),
            HumanMessagePromptTemplate.from_template(
                """
                User's recorded speech text: {speech_text}

                Please correct this text according to the following criteria:
                1. Grammatical accuracy
                2. Clarity of meaning
                3. Expressions suitable for Korean speakers aged 50-60
                """
            )
        ])

        self._document_correction_prompt = ChatPromptTemplate.from_messages([
            SystemMessagePromptTemplate.from_template(
                """
                You are a professional AI assistant specialized in document correction. 
                You must perfectly understand the linguistic characteristics of Korean speakers, 
                accurately capture context and intent, and correct text into natural Korean.
                Additionally, you should appropriately use line breaks, paragraph divisions, 
                and sentence structures to create a document that is easy for users to read.
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                - Consider grammar, vocabulary, and context comprehensively during correction.
                - Apply appropriate honorifics and formal language.
                - Absolutely do not add any additional information or sentences beyond the corrected content.
                """
            ),
            HumanMessagePromptTemplate.from_template(
                """
                Document provided by the user: {document_text}

                Correct this document according to the following criteria:
                1. Grammatical accuracy
                2. Clarity of meaning
                """
            )
        ])

    def correct_document_text(self, document_text):
        chain = self._document_correction_prompt | self.llm | StrOutputParser()

        response = chain.invoke({
            "document_text": document_text
        })

        return response

    def correct_speech_text(self, speech_text):
        chain = self._speech_correction_prompt | self.llm | StrOutputParser()

        response = chain.invoke({
            "speech_text": speech_text
        })

        return response
