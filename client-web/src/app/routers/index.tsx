import {Route, Routes} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts"
import {PrivateRoute} from "@shared/components/private-route";

import {
    Article,
    ArticleEditing,
    ArticleReading,
    ArticleWriting,
    Login,
    Question,
    QuestionDetail,
    Register,
    Waiting
} from "@pages/index.ts";

export default function Router() {

    return (
        <Routes>
            <Route path={CONSTANTS.ROUTER.LOGIN} element={<Login/>}/>
            <Route path={CONSTANTS.ROUTER.REGISTER} element={<Register/>}/>
            <Route path={CONSTANTS.ROUTER.WAITING} element={<Waiting/>}/>
            <Route element={<PrivateRoute/>}>
                <Route path={CONSTANTS.ROUTER.ARTICLE} element={<Article/>}/>
                <Route path={CONSTANTS.ROUTER.ARTICLE_WRITE} element={<ArticleWriting/>}/>
                <Route path={CONSTANTS.ROUTER.ARTICLE_READ + ":id"} element={<ArticleReading/>}/>
                <Route path={CONSTANTS.ROUTER.ARTICLE_EDIT + ":id"} element={<ArticleEditing/>}/>
                <Route path={CONSTANTS.ROUTER.QUESTION} element={<Question/>}/>
                <Route path={CONSTANTS.ROUTER.QUESTION_DETAIL + ":id"} element={<QuestionDetail/>}/>
            </Route>
        </Routes>
    )
}