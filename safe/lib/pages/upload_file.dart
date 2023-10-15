import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:safe/pages/encrption_file.dart';

import 'ontap_openfile.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<PlatformFile> recentFiles = [];

  Future<void> _selectFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final result = await FilePicker.platform
            .pickFiles(allowMultiple: true, withData: true, type: FileType.any);

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
                // Call the encryptFile function with the file path
                //await encryptFile(filePath);
                print("e2");
                setState(() {
                  recentFiles.add(PlatformFile(
                    name: fileName,
                    size: newFile.lengthSync(),
                    bytes: newFile.readAsBytesSync(),
                  ));
                });

                showSnackbar(context);
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

  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Your files uploded successfully'),
      duration: Duration(seconds: 3), // Adjust the duration as needed
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA), // Background color
      body: Stack(
        children: <Widget>[
          // Top left corner image
          Positioned(
            left: -15,
            top: 0,
            child: Image.asset(
              'assets/upr_corner.png',
              width: 100,
              height: 100,
            ),
          ),

          // Top right corner image
          Positioned(
            right: -15,
            top: 0,
            child: Image.asset(
              'assets/safe_logo.png',
              width: 200,
              height: 200,
            ),
          ),

          // Bottom right corner image
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
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 200),
                const Text(
                  "Upload Your Files",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/upload.png',
                  width: 150,
                  height: 150,
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
                    minimumSize: Size(200, 0), // Set the minimum button width
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Select File",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                                  file?.name ?? 'No File',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  print("h1");
                                  if (file?.bytes != null) {
                                    print("sadia: ${file?.bytes}");

                                    // Navigate to the FileViewerPage
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
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle send action
                                        // Implement your send logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0XFF6096B4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text(
                                        "Send",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          recentFiles.remove(file);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle upload action
                    // Implement your upload logic here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF6096B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(200, 0), // Set the minimum button width
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Upload",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
