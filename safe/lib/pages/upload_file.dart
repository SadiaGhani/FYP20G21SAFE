import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/pages/ontap_openfile.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<PlatformFile> recentFiles = [];
  List<PlatformFile> safeFiles = [];

  Future<void> _selectFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          withData: true,
          type: FileType.any,
        );

        if (result != null && result.files.isNotEmpty) {
          final externalDirectory = await getExternalStorageDirectory();

          if (externalDirectory != null) {
            final safefilesDirectory =
                Directory(path.join(externalDirectory.path, 'safefiles'));
            safefilesDirectory.createSync(recursive: true);

            for (PlatformFile file in result.files) {
              final fileName = path.basename(file.name);
              final filePath = path.join(
                externalDirectory.path,
                'safefiles',
                fileName,
              );

              print("File Path: $filePath");

              final newFile = File(filePath);
              if (file.bytes != null) {
                newFile.writeAsBytesSync(file.bytes!);
                print("e1");
                setState(() {
                  recentFiles.add(PlatformFile(
                    name: fileName,
                    size: newFile.lengthSync(),
                    bytes: newFile.readAsBytesSync(),
                  ));
                });

                showSnackbar(context, "Your files uploaded successfully");
              } else {
                print("File bytes are null for file: $fileName");
              }
            }
          } else {
            print("External storage directory is null.");
          }
        } else {
          print("No file selected.");
        }
      } catch (e) {
        print("Error picking file: $e");
      }
    } else {
      print("Storage permission not granted.");
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> encryptFile(PlatformFile? file) async {
    if (file == null || file.bytes == null) {
      print("File is null or has no bytes.");
      return;
    }

    final externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      final safefilesDirectory =
          Directory(path.join(externalDirectory.path, 'safefiles'));
      safefilesDirectory.createSync(recursive: true);

      final fileName = path.basename(file.name);
      final nameWithoutExtension = path.basenameWithoutExtension(fileName);
      final newFileName =
          'encrypted_$nameWithoutExtension.enc'; // New file name
      final filePath = path.join(safefilesDirectory.path, newFileName);
      final newFile = File(filePath);
      print("SGFN:$newFileName");
      final bytes = file.bytes!;

      final encryptedBytes = encryptBytes(bytes as List<int>);

      newFile.writeAsBytesSync(encryptedBytes);

      // Remove the original file
      File(file?.path ?? '').deleteSync();

      setState(() {
        recentFiles.add(PlatformFile(
          name: 'encrypted_$nameWithoutExtension.enc',
          size: newFile.lengthSync(),
          bytes: encryptedBytes,
        ));
      });

      showSnackbar(context, "File Encrypted Successfully");
    } else {
      print("External storage directory is null.");
    }
  }

  Uint8List encryptBytes(List<int> bytes) {
    // Replace this with your encryption logic
    // Example: Simple XOR encryption for demonstration purposes
    final key = [0x01, 0x02, 0x039]; // Replace with your encryption key
    for (int i = 0; i < bytes.length; i++) {
      bytes[i] ^= key[i % key.length];
    }
    return Uint8List.fromList(bytes);
  }

  // Decryption Function
  Future<void> decryptFile(PlatformFile file) async {
    final externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      final safefilesDirectory =
          Directory(path.join(externalDirectory.path, 'safefiles'));
      safefilesDirectory.createSync(recursive: true);

      final fileName = path.basename(file.name);
      final filePath = path.join(
        externalDirectory.path,
        'safefiles',
        fileName,
      );

      final newFile = File(filePath);
      if (file.bytes != null) {
        final bytes = file.bytes!;

        // Decrypt the file content
        final decryptedBytes = decryptBytes(bytes as List<int>);

        newFile.writeAsBytesSync(decryptedBytes);

        setState(() {
          recentFiles.add(PlatformFile(
            name: 'decrypted_$fileName',
            size: newFile.lengthSync(),
            bytes: decryptedBytes,
          ));
        });

        showSnackbar(context, "File Decrypted Successfully");
      } else {
        print("File bytes are null for file: $fileName");
      }
    } else {
      print("External storage directory is null.");
    }
  }

  Uint8List decryptBytes(List<int> bytes) {
    // Replace this with your decryption logic
    // Example: Simple XOR decryption for demonstration purposes
    final key = [0x01, 0x02, 0x039]; // Replace with your decryption key
    for (int i = 0; i < bytes.length; i++) {
      bytes[i] ^= key[i % key.length];
    }
    return Uint8List.fromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: -15,
            top: 0,
            child: Image.asset(
              'assets/upr_corner.png',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: -15,
            top: 0,
            child: Image.asset(
              'assets/safe_logo.png',
              width: 130,
              height: 130,
            ),
          ),
          Positioned(
            right: -15,
            bottom: 0,
            child: Image.asset(
              'assets/btm_corner.png',
              width: 100,
              height: 100,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                const Text(
                  "Upload Your Files",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/upload.png',
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _selectFile();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF6096B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(200, 0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Select File",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      DataTable(
                        columns: const [
                          DataColumn(label: Text("File Name")),
                          DataColumn(label: Text("Actions")),
                        ],
                        rows: recentFiles.map((PlatformFile? file) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  file?.name != null
                                      ? (file!.name.length > 20
                                          ? '${file?.name!.substring(0, 20)}...'
                                          : file.name)
                                      : 'No File',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  //print("h1");
                                  if (file?.bytes != null) {
                                    //print("sadia: ${file?.bytes}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FileViewerPage(selectedFile: file),
                                      ),
                                    );
                                  } else {
                                    print("no selection");
                                  }
                                },
                              ),
                              DataCell(
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'decrypt',
                                        child: Text("Decrypt"),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'encrypt',
                                        child: Text("Encrypt"),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text("Delete"),
                                      ),
                                    ];
                                  },
                                  onSelected: (String choice) async {
                                    if (choice == 'decrypt') {
                                      decryptFile(file!);
                                    } else if (choice == 'encrypt') {
                                      encryptFile(file!);
                                      showSnackbar(context,
                                          "File Encrypted Successfully");
                                    } else if (choice == 'delete') {
                                      if (file != null) {
                                        // Delete the file from the 'safefiles' directory
                                        final externalDirectory =
                                            await getExternalStorageDirectory();
                                        if (externalDirectory != null) {
                                          final safefilesDirectory = Directory(
                                              path.join(externalDirectory.path,
                                                  'safefiles'));
                                          final fileName =
                                              path.basename(file.name);
                                          final filePath = path.join(
                                              safefilesDirectory.path,
                                              fileName);
                                          final fileToDelete = File(filePath);

                                          if (fileToDelete.existsSync()) {
                                            fileToDelete.deleteSync();
                                          }
                                        }

                                        setState(() {
                                          recentFiles.remove(file);
                                          showSnackbar(context, "File Deleted");
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
