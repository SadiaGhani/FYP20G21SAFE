import 'package:flutter/material.dart';

// ignore: camel_case_types
class upload_btn extends StatelessWidget {
  const upload_btn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "upload_btn",
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Upload".toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}
