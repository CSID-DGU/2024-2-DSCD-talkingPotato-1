import { CONSTANTS } from "@app/constants/constants";
import { ArticleQueries } from "@entities/article";
import useConfirmMessage from "@shared/lib/confirm/use-confirm-message";
import { useSuspenseQuery } from "@tanstack/react-query";
import Confirm from "@widgets/confirm/confirm.ui";
import {
  ChangeEvent,
  useState,
  ReactElement,
  useEffect,
  Dispatch,
  SetStateAction,
  Fragment,
} from "react";
import { useNavigate } from "react-router-dom";
import useUpdateArticleMutation from "./update-article.mutation";
import MarkdownViewer from "@widgets/markdown/markdown-viewer/markdown-viewer.ui";
import { MarkdownEditor } from "@widgets/markdown/markdown-editor/markdown-editor.ui";

interface IUpdateArticleProps {
  articleId: number;
}

const UpdateArticle = (props: IUpdateArticleProps): ReactElement => {
  const { articleId } = props;

  const { data: article } = useSuspenseQuery(
    ArticleQueries.readArticleDetailQuery(articleId)
  );

  const [title, setTitle] = useState<string>("");
  const [tagInput, setTagInput] = useState<string>("");
  const [tags, setTags] = useState<string[]>([]);
  const [markdownValue, setMarkdownValue] = useState<string | undefined>("");

  const { mutate: updateArticle } = useUpdateArticleMutation();

  const handleTitleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setTitle(e.target.value);
  };

  const handleTagChange = (e: ChangeEvent<HTMLInputElement>) => {
    setTagInput(e.target.value);

    const newTag = e.target.value
      .split("#")
      .map((tag) => tag.trim())
      .filter((tag) => tag !== "");

    setTags(newTag);
  };

  const handleUpdateArticle = () => {
    updateArticle({
      articleId: article!.id,
      article: {
        title: title,
        tags: tags,
        content: markdownValue!,
      },
    });
  };

  useEffect(() => {
    if (article) {
      setTitle(article.title);
      setTags(article.tags);

      let tagInput = "#";

      tagInput += article.tags.join(" #");

      setTagInput(tagInput);

      setMarkdownValue(article.content);
    }
  }, [article]);

  return (
    <div className="flex flex-col w-full">
      <TopBar updateArticle={handleUpdateArticle} articleId={articleId} />
      <div className="flex flex-col w-full">
        <div className="flex flex-row flex-1 gap-2 p-5 h-full w-full">
          <ArticleInput
            title={title}
            handleTitleChange={handleTitleChange}
            tagInput={tagInput}
            handleTagInputChange={handleTagChange}
            markdownValue={markdownValue}
            setMarkdownValue={setMarkdownValue}
          />
          <ArticlePreview
            title={title}
            tags={tags}
            markdownValue={markdownValue!}
          />
        </div>
      </div>
    </div>
  );
};

export default UpdateArticle;

interface ITopBarProps {
  updateArticle: () => void;
  articleId: number;
}

const TopBar = (props: ITopBarProps): ReactElement => {
  const { updateArticle, articleId } = props;

  const navigate = useNavigate();

  const {
    isConfirmOpen,
    setIsConfirmOpen,
    setConfirmMessage,
    setConfirmTitle,
    confirmMessage,
    confirmTitle,
  } = useConfirmMessage();

  const onConfirm = () => {
    window.history.back();
  };

  const handleCancelButton = () => {
    setIsConfirmOpen(true);
    setConfirmTitle("작성중인 칼럼의 수정을 취소하시겠습니까?");
    setConfirmMessage("작성중인 칼럼은 저장되지 않습니다.");
  };

  const handleUpdateArticle = () => {
    updateArticle();
    navigate(
      CONSTANTS.ROUTER.ARTICLE_READ.replace(":id", articleId.toString())
    );
  };

  return (
    <div className="flex flex-row w-full justify-end items-center border-b border-neutral-700">
      <div className="flex flex-row gap-3 pt-2 pr-2">
        <button
          className="px-8 py-4 rounded-2xl bg-red-600 hover:bg-red-500"
          onClick={handleCancelButton}
        >
          <h4 className="text-h4 text-white">취소하기</h4>
        </button>
        <button
          className="px-8 py-4 rounded-2xl bg-secondary-500 hover:bg-secondary-400"
          onClick={handleUpdateArticle}
        >
          <h4 className="text-h4 text-white">수정하기</h4>
        </button>
      </div>
      {isConfirmOpen && (
        <Confirm
          title={confirmTitle}
          content={confirmMessage}
          onConfirm={onConfirm}
          onCancel={() => setIsConfirmOpen(false)}
        />
      )}
    </div>
  );
};

interface IArticleInputProps {
  title: string;
  handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
  tagInput: string;
  handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
  markdownValue: string | undefined;
  setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

const ArticleInput = (props: IArticleInputProps): ReactElement => {
  return (
    <div className="flex flex-col flex-1 overflow-y-auto p-5">
      <TitleInput
        title={props.title}
        handleTitleChange={props.handleTitleChange}
      />
      <TagInput
        tagInput={props.tagInput}
        handleTagInputChange={props.handleTagInputChange}
      />
      <ContentInput
        markdownValue={props.markdownValue}
        setMarkdownValue={props.setMarkdownValue}
      />
    </div>
  );
};

interface ITitleInputProps {
  title: string;
  handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

const TitleInput = (props: ITitleInputProps): ReactElement => {
  return (
    <div className="flex flex-col mb-10">
      <div className="flex flex-row items-center w-full mb-8">
        <p className="text-sub2 text-primary-500 whitespace-nowrap mr-3">
          제목
        </p>
        <div className="flex-1 h-[1px] bg-primary-500"></div>
      </div>
      <input
        className="w-full p-4 rounded-lg border border-neutral-700 text-sub2"
        placeholder="제목을 입력하세요"
        value={props.title}
        onChange={props.handleTitleChange}
      />
    </div>
  );
};

interface ITagInputProps {
  tagInput: string;
  handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

const TagInput = (props: ITagInputProps): ReactElement => {
  return (
    <div className="flex flex-col mb-10">
      <div className="flex flex-row items-center w-full mb-8">
        <p className="text-sub2 text-primary-500 whitespace-nowrap mr-3">
          태그
        </p>
        <div className="flex-1 h-[1px] bg-primary-500"></div>
      </div>
      <input
        className="w-full p-4 rounded-lg border border-neutral-700 text-sub2"
        placeholder="태그를 입력하세요"
        value={props.tagInput}
        onChange={props.handleTagInputChange}
      />
    </div>
  );
};

interface IContentInputProps {
  markdownValue: string | undefined;
  setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

const ContentInput = (props: IContentInputProps): ReactElement => {
  return (
    <div className="flex flex-col mb-10">
      <div className="flex flex-row items-center w-full mb-8">
        <p className="text-sub2 text-primary-500 whitespace-nowrap mr-3">
          내용
        </p>
        <div className="flex-1 h-[1px] bg-primary-500"></div>
      </div>
      <MarkdownEditor
        markdownValue={props.markdownValue}
        setMarkdownValue={props.setMarkdownValue}
      />
    </div>
  );
};

interface IArticlePreviewProps {
  title: string;
  tags: string[];
  markdownValue: string | undefined;
}

const ArticlePreview = (props: IArticlePreviewProps): ReactElement => {
  return (
    <div className="flex flex-col flex-1 overflow-y-auto p-5">
      {props.title.length > 0 ? (
        <h1 className="text-h0 text-start text-black">{props.title}</h1>
      ) : (
        <div className="h-[60px]"></div>
      )}
      <div className="flex flex-row gap-2 mt-3">
        {props.tags.length > 0 ? (
          props.tags.map((tag, index) => (
            <Fragment key={index}>
              <Tag tag={tag} isFirst={index === 0} />
            </Fragment>
          ))
        ) : (
          <div className="h-6" />
        )}
      </div>
      <div className="w-full h-[1px] bg-neutral-700 my-10" />
      <MarkdownViewer markdownValue={props.markdownValue!} />
    </div>
  );
};

interface ITagProps {
  tag: string;
  isFirst: boolean;
}

const Tag = (props: ITagProps): ReactElement => {
  return (
    <div
      className={`flex flex-col items-center justify-center px-5 h-6 bg-secondary-900 rounded-full ${props.isFirst ? "ml-0" : "ml-3"}`}
    >
      <p className="text-sub2 text-center text-primary-500">{props.tag}</p>
    </div>
  );
};
