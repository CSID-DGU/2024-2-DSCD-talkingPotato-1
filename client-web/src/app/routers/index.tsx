import { Route, Routes } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants.ts";
import { PrivateRoute } from "@app/provider";

import {
  ArticlePage,
  ArticleEditingPage,
  ArticleReadingPage,
  ArticleWritingPage,
  LoginPage,
  QuestionPage,
  QuestionReadingPage,
  RegisterPage,
  WaitingPage,
} from "@pages/index.ts";

export default function Router() {
  return (
    <Routes>
      <Route path={CONSTANTS.ROUTER.LOGIN} element={<LoginPage />} />
      <Route path={CONSTANTS.ROUTER.REGISTER} element={<RegisterPage />} />
      <Route path={CONSTANTS.ROUTER.WAITING} element={<WaitingPage />} />
      <Route element={<PrivateRoute />}>
        <Route path={CONSTANTS.ROUTER.ARTICLE} element={<ArticlePage />} />
        <Route
          path={CONSTANTS.ROUTER.ARTICLE_WRITE}
          element={<ArticleWritingPage />}
        />
        <Route
          path={CONSTANTS.ROUTER.ARTICLE_READ + ":id"}
          element={<ArticleReadingPage />}
        />
        <Route
          path={CONSTANTS.ROUTER.ARTICLE_EDIT + ":id"}
          element={<ArticleEditingPage />}
        />
        <Route path={CONSTANTS.ROUTER.QUESTION} element={<QuestionPage />} />
        <Route
          path={CONSTANTS.ROUTER.QUESTION_DETAIL + ":id"}
          element={<QuestionReadingPage />}
        />
      </Route>
    </Routes>
  );
}
