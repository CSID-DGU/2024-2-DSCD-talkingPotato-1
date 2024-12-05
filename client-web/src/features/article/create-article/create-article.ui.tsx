import { CONSTANTS } from "@app/constants/constants";
import { useNavigate } from "react-router-dom";
import {
  ChangeEvent,
  Dispatch,
  Fragment,
  ReactElement,
  SetStateAction,
  useState,
} from "react";
import { useConfirmMessage } from "@shared/lib/confirm/use-confirm-message";
import { Confirm } from "@widgets/confirm";
import useCreateArticleMutation from "./create-article.mutation";
import { MarkdownEditor } from "@widgets/markdown/markdown-editor/markdown-editor.ui";
import { MarkdownViewer } from "@widgets/markdown/markdown-viewer";
import { useAlertMessage } from "@shared/lib/alert/use-alert-message";
import Alert from "@widgets/alert/alert.ui";

const CreateArticle = (): ReactElement => {
  const [title, setTitle] = useState<string>("");
  const [tagInput, setTagInput] = useState<string>("");
  const [tags, setTags] = useState<string[]>([]);
  const [markdownValue, setMarkdownValue] = useState<string | undefined>("");

  const { isAlertOpen, alertMessage, setIsAlertOpen, setAlertMessage } =
    useAlertMessage();

  const navigate = useNavigate();

  const { mutate: createArticle } = useCreateArticleMutation();

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

  const handleCreateArticle = () => {
    if (
      title.length === 0 ||
      markdownValue === undefined ||
      tags.length === 0
    ) {
      setIsAlertOpen(true);
      setAlertMessage("입력을 확인해주세요.");
      return;
    }

    createArticle({
      title,
      content: markdownValue!,
      tags,
    });

    navigate(CONSTANTS.ROUTER.ARTICLE);
  };

  return (
    <div className="flex flex-col w-full h-screen">
      <TopBar onClick={handleCreateArticle} />
      <div className="flex flex-row w-full h-full flex-1 gap-3 p-5 ">
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
      {isAlertOpen && (
        <Alert title={alertMessage} onClick={() => setIsAlertOpen(false)} />
      )}
    </div>
  );
};

export default CreateArticle;

interface ITopBarProps {
  onClick: () => void;
}

const TopBar = (props: ITopBarProps): ReactElement => {
  const navigate = useNavigate();
  const { onClick } = props;

  const {
    isConfirmOpen,
    setIsConfirmOpen,
    setConfirmTitle,
    setConfirmMessage,
    confirmTitle,
    confirmMessage,
  } = useConfirmMessage();

  const onComfirm = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE);
  };

  const handleCancleButtonClick = () => {
    setIsConfirmOpen(true);
    setConfirmTitle("작성중인 칼럼을 삭제하시겠습니까?");
    setConfirmMessage("작성중인 칼럼은 저장되지 않습니다.");
  };

  return (
    <div className="flex flex-row w-full justify-end items-center border-b border-neutral-700">
      <div className="flex flex-row gap-3 pt-2 pr-2">
        <button
          className="px-8 py-4 rounded-2xl bg-red-600 hover:bg-red-500"
          onClick={handleCancleButtonClick}
        >
          <h4 className="text-h4 text-white">취소하기</h4>
        </button>
        <button
          className="px-8 py-4 rounded-2xl bg-secondary-500 hover:bg-secondary-400"
          onClick={onClick}
        >
          <h4 className="text-h4 text-white">등록하기</h4>
        </button>
      </div>
      {isConfirmOpen && (
        <Confirm
          title={confirmTitle}
          content={confirmMessage}
          onConfirm={onComfirm}
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
        className="w-full p-4 rounded-xl border border-neutral-700 text-sub2"
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
        className="w-full p-4 rounded-xl border border-neutral-700 text-sub2"
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
