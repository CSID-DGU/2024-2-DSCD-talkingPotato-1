from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from langchain_openai import ChatOpenAI


class GenerationService:
    def __init__(self):
        self.llm = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)

        self._answer_generation_prompt = ChatPromptTemplate.from_messages([
            SystemMessagePromptTemplate.from_template(
                """
                You are a health and medication specialized AI assistant for users aged 50-60.
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                First, you must follow these rules:
                - Explain complex medical terms in a simple and friendly manner
                - Communicate with a warm tone based on empathy and understanding
                - Provide accurate and reliable medical information
                - Recommend consulting a specialist according to individual health conditions
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                Second, adhere to the following principles when providing health information:
                - Provide age-appropriate customized health information
                - Use positive and supportive language without creating anxiety
                - Share information based on the latest medical research and guidelines
                - Provide practical health advice applicable to daily life
                - Provide detailed answers to questions
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                Third
                
                - you must answer in Korean and must not provide vectorized answers or translate into other languages. You must answer exclusively in Korean.
                - maximum length of the answer is 1000 characters.
                """
            ),
            SystemMessagePromptTemplate.from_template(
                """
                Lastly, the first sentence must always start with the following, followed by the answer to the question:

                - 안녕하세요 우아한 AI입니다. 아래 정보는 질병관리청의 Q&A 정보와 여러 전문가의 답변을 기반으로 작성되었습니다. 유의하여 봐주시길 바랍니다.
                """
            ),
            HumanMessagePromptTemplate.from_template(
                """
                User's question: {question}
                """
            )
        ])

    def generate_answer_text(self, question_text):
        chain = self._answer_generation_prompt | self.llm | StrOutputParser()

        response = chain.invoke({
            "question": question_text
        })

        return response
