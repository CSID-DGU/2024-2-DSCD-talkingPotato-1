import * as Styled from "./update-preview-section.style.ts";
import {Fragment, ReactElement} from "react";
import {Head0, SizedBox} from "@shared/components";
import {
    ArticleCreateTag
} from "@features/article/article-create/article-create-section/create-preview-section/article-create-tag";
import {theme} from "@app/styles";
import {MarkdownViewer} from "@features/article";

interface props {
    title: string;
    tags: string[];
    markdownValue: string;
}

export const UpdatePreviewSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            {
                props.title === "" ? (
                    <SizedBox height={"60px"}/>
                ) : <Head0 text={props.title} textAlign={"start"}/>
            }
            <SizedBox height={"12px"}/>
            <Styled.TagWrapper>
                {
                    props.tags.length > 0 ? (
                        props.tags.map((tag, index) => (
                            <Fragment key={index}>
                                <ArticleCreateTag tag={tag} isFirst={index === 0}/>
                            </Fragment>
                        ))
                    ) : (
                        <SizedBox height={"24px"}/>
                    )
                }
            </Styled.TagWrapper>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["700"]} margin={"40px 0"}/>
            <MarkdownViewer markdownValue={props.markdownValue!}/>
        </Styled.Container>
    )
}

export default UpdatePreviewSection;