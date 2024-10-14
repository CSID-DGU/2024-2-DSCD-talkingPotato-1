export const CONSTANTS = {
    ROUTER: {
        DASHBOARD: "/",
        REGISTER: "/register",
        LOGIN: "/login",
        WAITING: "/waiting",
        ARTICLE: "/articles",
        ARTICLE_WRITE: "/articles/write",
        ARTICLE_EDIT: "/articles/edit/",
        ARTICLE_READ: "/articles/",
        QUESTION: "/questions",
        QUESTION_DETAIL: "/questions/",
    },
    REGEX: {
        EMAIL: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/,
        PASSWORD: /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/,
    }
}