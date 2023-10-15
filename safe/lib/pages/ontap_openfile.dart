import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:open_file/open_file.dart';

class FileViewerPage extends StatefulWidget {
  final PlatformFile? selectedFile;

  FileViewerPage({Key? key, this.selectedFile}) : super(key: key);

  @override
  _FileViewerPageState createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {
  Uint8List? fileBytes;
  VideoPlayerController? _videoController;
  bool isPlaying = false; // Track the video's playing state

  @override
  void initState() {
    super.initState();
    print("Selected File: ${widget.selectedFile?.name}");
    if (widget.selectedFile != null) {
      _openSelectedFile(widget.selectedFile);
      print("File Path: ${widget.selectedFile?.path}");
    }
  }

  File createFileFromBytesSync(Uint8List bytes, String fileName) {
    final file = File('${Directory.systemTemp.path}/$fileName');
    file.writeAsBytesSync(bytes);
    return file;
  }

  Future<void> _openSelectedFile(PlatformFile? selectedFile) async {
    if (selectedFile != null) {
      final fileData = selectedFile.bytes;

      if (fileData != null) {
        setState(() {
          fileBytes = fileData;
          if (_isVideo(selectedFile.name)) {
            // Handle video files as before.
            final file = createFileFromBytesSync(fileData, selectedFile.name);
            _videoController = VideoPlayerController.file(file)
              ..initialize().then((_) {
                setState(() {});
              });
          } else if (_isImage(selectedFile.name)) {
            // Handle image files with custom height and width.
            // You can adjust these values as needed.
            fileBytes = fileData;
          } else if (_isTextFile(selectedFile.name)) {
            // Handle text-based files.
            final file = createFileFromBytesSync(fileData, selectedFile.name);
            _openTextFile(file.path);
          }
        });
      } else {
        print("File data is null.");
      }
    } else {
      print("No file selected.");
    }
  }

  bool _isVideo(String fileName) {
    final fileExtension = fileName.split('.').last.toLowerCase();
    return ['mp4', 'avi', 'mov'].contains(fileExtension);
  }

  bool _isImage(String fileName) {
    final fileExtension = fileName.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(fileExtension);
  }

  bool _isTextFile(String fileName) {
    final fileExtension = fileName.split('.').last.toLowerCase();
    return ['txt', 'pdf', 'docx'].contains(fileExtension);
  }

  Future<void> _openTextFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.done) {
      if (result.message != null) {
        print("File opened with ${result.message}");
      } else {
        print("File opened successfully.");
      }
    }
  }

  void togglePlayPause() {
    if (_videoController != null) {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
      setState(() {
        isPlaying = _videoController!.value.isPlaying;
      });
    }
  }

  Widget _buildFileViewer() {
    if (_videoController != null) {
      return Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
            ElevatedButton(
              onPressed: togglePlayPause,
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      );
    } else if (fileBytes != null) {
      final fileName = widget.selectedFile!.name;
      final fileExtension = fileName.split('.').last.toLowerCase();

      if (_isImage(fileName)) {
        return Center(
          child: Container(
            height: 640,
            width: 280,
            child: Image.memory(fileBytes!),
          ),
        );
      } else {
        return Text("File Viewer for: $fileName");
      }
    } else {
      return Text("No file selected or file data is null.");
    }
  }

  @override
  void dispose() {
    if (_videoController != null) {
      _videoController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Viewer"),
      ),
      body: SingleChildScrollView(child: _buildFileViewer()),
    );
  }
}
