import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<PlatformFile> recentFiles = [];

  Future<void> _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          recentFiles.add(result.files.single);
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
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
              width: 150,
              height: 150,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
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
                    minimumSize: const Size(200, 0), // Set the minimum button width
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
                        rows: recentFiles.map((PlatformFile file) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Container( // Wrap the file name in a container
                                  width: 120, // Set a fixed or responsive width here
                                  child: Text(
                                    file.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                onTap: () {
                                  // Handle tap on file entity
                                },
                              ),
                              DataCell(
                                Container( // Wrap the buttons in a container
                                  width: 200, // Set a fixed or responsive width here
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle send action
                                          // Implement your send logic here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0XFF6096B4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "Send",
                                          style: TextStyle(
                                            fontSize: 10,
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
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle upload action
                //     // Implement your upload logic here
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: const Color(0XFF6096B4),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     minimumSize: const Size(200, 0), // Set the minimum button width
                //   ),
                //   child: const Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Text(
                //       "Upload",
                //       style: TextStyle(fontSize: 18, color: Colors.white),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
