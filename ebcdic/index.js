const { Storage } = require("@google-cloud/storage");
const iconv = require("iconv-lite");
const axios = require("axios"); // To send data to NestJS

const storage = new Storage();

exports.processEbcdicBatch = async (req, res) => {
  const bucketName = "your-ebcdic-bucket-a"; // Or get from env var
  const nestJsUrl = process.env.NESTJS_AUDIT_URL;
  const jsonArray = [];

  try {
    // 1. List all files in the bucket
    const [files] = await storage.bucket(bucketName).getFiles();
    console.log(`Found ${files.length} files to process.`);

    for (const file of files) {
      // 2. Download the file as a Buffer (raw bytes)
      const [content] = await file.download();

      // 3. Decode from EBCDIC (Commonly 'cp037' for US English)
      const decodedString = iconv.decode(content, "cp037");

      // 4. Parse fixed-width fields (Example offsets)
      const record = {
        fileName: file.name,
        businessName: decodedString.substring(0, 50).trim(),
        address: decodedString.substring(50, 150).trim(),
        phoneNumber: decodedString.substring(150, 162).trim(),
        rawLength: content.length,
      };

      jsonArray.push(record);
    }

    // 5. Send the batch to NestJS for Value Verification & Postgres Audit
    if (jsonArray.length > 0) {
      await axios.post(nestJsUrl, {
        batchId: Date.now(),
        data: jsonArray,
      });
    }

    res.status(200).send(`Processed ${jsonArray.length} records successfully.`);
  } catch (error) {
    console.error("Error during batch processing:", error);
    res.status(500).send(error.message);
  }
};
