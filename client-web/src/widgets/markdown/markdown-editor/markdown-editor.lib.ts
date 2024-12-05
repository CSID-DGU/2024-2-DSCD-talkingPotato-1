import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import { v4 as uuidv4 } from "uuid";

interface IS3Params {
  Bucket: string;
  Key: string;
  Body: File;
}

export class MarkdownEditorUtil {
  static uploadImage = async (file: File): Promise<string> => {
    const bucket = import.meta.env.VITE_AWS_BUCKET_NAME;
    const region = import.meta.env.VITE_AWS_REGION;

    const fileExtension = file.name.split(".").pop();
    const fileName = `${uuidv4()}.${fileExtension}`;

    const client = new S3Client({
      region: region,
      credentials: {
        accessKeyId: import.meta.env.VITE_AWS_ACCESS_KEY_ID,
        secretAccessKey: import.meta.env.VITE_AWS_SECRET_ACCESS_KEY,
      },
    });

    const params: IS3Params = {
      Bucket: bucket,
      Key: fileName,
      Body: file,
    };

    await client.send(new PutObjectCommand(params));

    const fileUrl = `https://${bucket}.s3.${region}.amazonaws.com/${fileName}`;
    return fileUrl;
  };
}
