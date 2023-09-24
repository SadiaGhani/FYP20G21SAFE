import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({Key? key}) : super(key: key);

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  List<PlatformFile>? _selectedFiles;

  void _uploadFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _selectedFiles = result.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _uploadFiles,
          child: Text("Upload Files"),
        ),
        if (_selectedFiles != null)
          Column(
            children: _selectedFiles!
                .map((file) => ListTile(title: Text(file.name)))
                .toList(),
          ),
      ],
    );
  }
}
