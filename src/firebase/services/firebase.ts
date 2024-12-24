import { logErrorAsyncMessage, logMessage } from "../../common";
import { bucket } from "./config";

async function listFilesInFolder(folderPath: string) {
  try {
    const [files] = await bucket.getFiles({
      prefix: folderPath,
    });

    // Filter out the folder path itself
    return files
      .filter((file: { name: string }) => !file.name.endsWith('/'))
      .map((file: { name: string }) => `https://firebasestorage.googleapis.com/v0/b/${bucket.name}/o/${encodeURIComponent(file.name)}?alt=media`);
  } catch (error) {
    logMessage(
      `${logErrorAsyncMessage('Error listing files :', `${error}:`)},
      ${error}`
    );
    throw error;
  }
}

  export {listFilesInFolder}