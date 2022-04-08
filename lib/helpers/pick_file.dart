import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PickFile {
  Future<String> pickOneImage(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg'],
      );
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Hình ảnh không hợp lệ vui lòng chọn ảnh khác!"),
          ),
        );
        return Future<String>.value("");
      }

      final bytes = result.files.single.size;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      if (mb > 5.5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Hình ảnh có kích thước quá lớn vui chọn ảnh khác!"),
          ),
        );
        return Future<String>.value("");
      }

      final path = result.files.single.path!;

      return Future<String>.value(path);
    } catch (e) {
      print(e);
      return Future<String>.value();
    }
  }

  // Future<List<String>> pickMultiImage(BuildContext context) async {
  //   try {
  //     final result = await ImagePicker().pickMultiImage(imageQuality: 5);

  //     if (result == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Hình ảnh không hợp lệ vui lòng chọn ảnh khác!"),
  //         ),
  //       );
  //       return Future<List<String>>.value();
  //     }

  //     final bytes = result.files.single.size;
  //     final kb = bytes / 1024;
  //     final mb = kb / 1024;
  //     if (mb > 5.5) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Hình ảnh có kích thước quá lớn vui chọn ảnh khác!"),
  //         ),
  //       );
  //       return Future<List<String>>.value();
  //     }

  //     final path = result.files.path!;

  //     return Future<List<String>>.value(path);
  //   } catch (e) {
  //     print(e);
  //     return Future<List<String>>.value();
  //   }
  // }

  Future<String> pickFilePdf(BuildContext context) async {
    try {
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
        return Future<String>.value("");
      }

      final path = result.files.single.path!;
      return Future<String>.value(path);
    } catch (e) {
      return Future<String>.value();
    }
  }

  static Future<File> createFileOfPdfUrl(String url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
