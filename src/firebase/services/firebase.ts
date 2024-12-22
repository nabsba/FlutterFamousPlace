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
        .map((file: { name: string }) => file.name);
    } catch (error) {
      logMessage(
        `${logErrorAsyncMessage('Error listing files :', `${error}:`)},
        ${error}`
      );
      throw error;
    }
  }
  
  export {listFilesInFolder}