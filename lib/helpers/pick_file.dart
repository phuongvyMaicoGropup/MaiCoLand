


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickFile{
  Future<String> pickImage(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hình ảnh không hợp lệ vui lòng nhập lại!"),
        ),
      );
      return Future<String>.value(null);
    }

    final path = result.files.single.path!;
    return Future<String>.value(path);
    }
   Future<File> pickFilePdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File không hợp lệ . Vui lòng chọn file khác!"),
        ),
      );
      return Future<File>.value(null);
    }

   
    final path = result.files.single.path!;
    return Future<File>.value(File(path));
    }
   
  

}