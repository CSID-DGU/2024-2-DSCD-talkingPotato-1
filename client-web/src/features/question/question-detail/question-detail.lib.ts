export interface QuestionDetailInterface {
    id: number;
    content: string;
    createdAt: string;
    creator: string;
    answers: QuestionAnswerInterface[];
}

export type AnswerStatus = "answered_by_llm" | "answered_by_expert";

export interface QuestionAnswerInterface {
    id: number;
    content: string;
    createdAt: string;
    creator: string;
    status: AnswerStatus;
    isMine: boolean;
}