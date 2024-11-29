import {queryOptions} from "@tanstack/react-query";
import {ArticleService} from "./article.service.ts";

export class ArticleQueries {
    static readonly keys = {
        list: ['article', 'list'] as const,
        detail: (id: number) => ['article', 'detail', id] as const,
    }

    static readArticleListQuery() {
        return queryOptions({
            queryKey: [...this.keys.list],
            queryFn: async () => {
                const response = await ArticleService.readArticleListQuery();
                return response.data;
            }
        })
    }

    static readArticleDetailQuery(id: number) {
        return queryOptions({
            queryKey: [...this.keys.detail(id)],
            queryFn: async () => {
                const response = await ArticleService.readArticleQuery(id);
                return response.data;
            }
        })
    }
}

export default ArticleQueries;