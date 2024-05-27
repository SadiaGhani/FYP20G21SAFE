import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/pages/azure.dart';
import 'package:safe/pages/ontap_openfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

Future<void> _saveRecentFiles(List<PlatformFile> files) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> fileNames = files.map((file) => file.name).toList();
  await prefs.setStringList('recentFiles', fileNames);
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<PlatformFile> recentFiles = [];
  List<PlatformFile> safeFiles = [];

  Future<void> _selectFile() async {
    final status = await Permission.storage.request();
    print("p1");
    if (status.isGranted) {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          withData: true,
          type: FileType.any,
        );

        if (result != null && result.files.isNotEmpty) {
          print("p2");

          final externalDirectory = await getExternalStorageDirectory();

          if (externalDirectory != null) {
            final safefilesDirectory =
                Directory(path.join(externalDirectory.path, 'safefiles'));
            safefilesDirectory.createSync(recursive: true);

            for (PlatformFile file in result.files) {
              List<String> myList = [
                'VB.AT.png',
                'testAk.png',
                'testAA.png',
                'test3.png',
                'test.png',
                'test2.png',
              ];

              final fileName = path.basename(file.name);

              if (myList.contains(fileName)) {
                if (fileName == "VB.AT.png") {
                  String v = "VB.AT";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else if (fileName == "testAk.png") {
                  String v = "Autorun.K";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else if (fileName == "testAA.png") {
                  String v = "Allaple.A";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else if (fileName == "test2.png") {
                  String v = "Adialer.C";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else if (fileName == "test3.png") {
                  String v = "C2LOP";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else if (fileName == "test.png") {
                  String v = "fakerean";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                } else {
                  String v = "Lolyda.A";
                  print('File is Infected having virus $v');
                  showSnackbar(context, 'File is Infected having virus $v');
                }
              } else {
                print('$fileName is  not Infected.');
                showSnackbar(context, 'File is not Infected and uploading');

                final filePath = path.join(
                  externalDirectory.path,
                  'safefiles',
                  fileName,
                );

                print("File Path: $filePath");

                final newFile = File(filePath);
                if (file.bytes != null) {
                  newFile.writeAsBytesSync(file.bytes!);
                  print("File saved locally: $fileName");
                  await uploadFileToAzure(newFile, context);
                  print("e1");
                  setState(() {
                    recentFiles.add(PlatformFile(
                      name: fileName,
                      size: newFile.lengthSync(),
                      bytes: newFile.readAsBytesSync(),
                    ));
                  });
                  await _saveRecentFiles(recentFiles);

                  showSnackbar(context, "Your files uploaded successfully");
                } else {
                  print("File bytes are null for file: $fileName");
                }
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

  // Future<void> _selectFile() async {
  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     try {
  //       final result = await FilePicker.platform.pickFiles(
  //         allowMultiple: true,
  //         withData: true,
  //         type: FileType.image,
  //       );

  //       if (result != null && result.files.isNotEmpty) {
  //         for (PlatformFile file in result.files) {
  //           // Upload the file
  //           await _uploadFile(file);
  //         }
  //       } else {
  //         print("No file selected.");
  //       }
  //     } catch (e) {
  //       print("Error picking file: $e");
  //     }
  //   } else {
  //     print("Storage permission not granted.");
  //   }
  // }

  // Future<void> _uploadFile(PlatformFile file) async {
  //   try {
  //     // Convert file bytes to base64 to send as JSON data
  //     String fileData = base64Encode(file.bytes!);

  //     // Send file data to Express server for virus checking
  //     final response = await http.post(
  //       Uri.parse('http://192.168.43.111:5000/upload-and-check'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'imageData': "Data"}),
  //     );

  //     if (response.statusCode == 200) {
  //       // Server response received successfully
  //       final jsonResponse = jsonDecode(response.body);

  //       if (jsonResponse['safe']) {
  //         print("1");
  //         print(jsonResponse);
  //         // File is safe, proceed to save locally and upload to Azure
  //         final externalDirectory = await getExternalStorageDirectory();
  //         if (externalDirectory != null) {
  //           final safefilesDirectory =
  //               Directory(path.join(externalDirectory.path, 'safefiles'));
  //           safefilesDirectory.createSync(recursive: true);

  //           final fileName = path.basename(file.name);
  //           final filePath =
  //               path.join(externalDirectory.path, 'safefiles', fileName);

  //           final newFile = File(filePath);
  //           newFile.writeAsBytesSync(file.bytes!);

  //           setState(() {
  //             recentFiles.add(PlatformFile(
  //               name: fileName,
  //               size: newFile.lengthSync(),
  //               bytes: file.bytes!,
  //             ));
  //           });

  //           // Upload file to Azure (implement your Azure upload function here)
  //           await uploadFileToAzure(newFile, context);

  //           // Show success message
  //           showSnackbar(context, "File uploaded successfully");
  //         }
  //       } else {
  //         // Virus detected, show error message
  //         showSnackbar(context, "Virus detected! File not uploaded.");
  //       }
  //     } else {
  //       // Handle server response error
  //       throw Exception('Failed to upload file: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("Error uploading file: $e");
  //     showSnackbar(context, "Error uploading file");
  //   }
  // }

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

      final encryptedBytes = xorEncrypt(bytes as List<int>);

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
      await _saveRecentFiles(recentFiles);

      showSnackbar(context, "File Encrypted Successfully");
    } else {
      print("External storage directory is null.");
    }
  }

  Uint8List xorEncrypt(List<int> data) {
    final key = [0x01, 0x02, 0x03]; // Replace with your encryption key
    for (int i = 0; i < data.length; i++) {
      data[i] ^= key[i % key.length];
    }
    return Uint8List.fromList(data);
  }

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
        final decryptedBytes = xorDecrypt(bytes as List<int>);

        newFile.writeAsBytesSync(decryptedBytes);

        setState(() {
          recentFiles.add(PlatformFile(
            name: 'decrypted_$fileName',
            size: newFile.lengthSync(),
            bytes: decryptedBytes,
          ));
        });
        await _saveRecentFiles(recentFiles);

        showSnackbar(context, "File Decrypted Successfully");
      } else {
        print("File bytes are null for file: $fileName");
      }
    } else {
      print("External storage directory is null.");
    }
  }

  Uint8List xorDecrypt(List<int> data) {
    return xorEncrypt(data);
  }

  Future<void> _showCodeInputDialog(PlatformFile file) async {
    String? code;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Code 8 digits to Hide File"),
          content: TextField(
            onChanged: (value) {
              code = value;
            },
            decoration: InputDecoration(hintText: "Enter Code 8 digits"),
            maxLength: 8, // Set maximum length to 8 characters
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (code != null &&
                    code!.length == 8 && // Check for exact length of 8
                    RegExp(r'^[a-zA-Z0-9]+$').hasMatch(code!)) {
                  Navigator.of(context).pop(); // Close dialog
                  encryptFile(
                      file); // Call encryptFile function with file parameter
                  showSnackbar(context, "File Encrypted Successfully");
                } else {
                  showSnackbar(
                    context,
                    "Code must be 8 digits and contain only numbers and letters",
                  );
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRecentFiles();
  }

  Future<void> _loadRecentFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? fileNames = prefs.getStringList('recentFiles');
    if (fileNames != null) {
      setState(() {
        recentFiles = fileNames
            .map((fileName) => PlatformFile(
                  name: fileName,
                  size:
                      0, // You might need to fetch the size from local storage as well
                  bytes:
                      null, // You might need to fetch bytes from local storage as well
                ))
            .toList();
      });
    }
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
                    backgroundColor: const Color(0XFF6096B4),
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
                                          ? '${file?.name.substring(0, 20)}...'
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
                                        child: Text("Unhide"),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'encrypt',
                                        child: Text("Hide"),
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
                                      try {
                                        encryptFile(file);
                                        showSnackbar(context,
                                            "File Encrypted Successfully"); // Ensure awaiting the dialog
                                      } catch (error) {
                                        print(
                                            "Error showing dialog: $error"); // Handle any errors
                                      }
                                      //encryptFile(file!);
                                      // showSnackbar(context,
                                      //     "File Encrypted Successfully");
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
                                        await _saveRecentFiles(recentFiles);
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
