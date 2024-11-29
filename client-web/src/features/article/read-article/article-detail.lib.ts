export interface ArticleDetailInterface {
    id: number;
    title: string;
    content: string;
    hashtags: string[];
    createdAt: string;
    creator: string;
    comments: ArticleCommentInterface[];
}

export interface ArticleCommentInterface {
    id: number;
    content: string;
    createdAt: string;
    creator: string;
}