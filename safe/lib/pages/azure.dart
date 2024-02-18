import 'dart:io';
import 'dart:typed_data';

import 'package:azblob/azblob.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

Future uploadFileToAzure(File file, BuildContext context) async {
  try {
    String fileName = basename(file.path);
    Uint8List content = await file.readAsBytes();
    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;AccountName=safeappstore;AccountKey=J3ZrTwTaFbaGjYC1fllRYV89+5TjC0DRzfN44LzGYtbrOGYbR6GDSmDraOBiyDI9BuqP1KNrJXLv+AStoRv+rw==;EndpointSuffix=core.windows.net');
    String container =
        "safecontainer"; // Change the container name if necessary
    String? contentType = lookupMimeType(fileName);
    await storage.putBlob('/$container/$fileName',
        bodyBytes: content, contentType: contentType, type: BlobType.BlockBlob);
    print("File uploaded successfully");
  } on AzureStorageException catch (ex) {
    print(ex.message);
  } catch (err) {
    print(err);
  }
}
