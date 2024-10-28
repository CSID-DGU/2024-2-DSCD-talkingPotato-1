export interface ArticleReadingInterface {
    id: number;
    title: string;
    content: string;
    hashtags: string[];
    createdAt: string;
    creator: string;
    comments: [
        {
            id: number;
            content: string;
            createdAt: string;
            creator: string;
        }
    ]
}