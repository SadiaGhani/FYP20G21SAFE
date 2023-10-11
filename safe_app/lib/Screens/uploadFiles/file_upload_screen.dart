import 'package:flutter/material.dart';
import 'package:safe_app/Screens/uploadFiles/components/uploadimage.dart';
import 'package:safe_app/responsive.dart';

import '../../components/background.dart';
import 'components/upload_form.dart'; // We will create this later
import 'components/uploaded_files.dart'; // We will create this later

class MobileFileUploadScreen extends StatelessWidget {
  const MobileFileUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileFileUploadScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: UploadImage(),
              ),
              Expanded(
                child: UploadedFiles(), // Widget to display uploaded files
              ),
              Expanded(
                child: UploadForm(), // Widget for file upload form
              ),
            ],
          ),
        ),
      ),
    );
  }
}
