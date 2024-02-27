import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

class FilePickerDialog extends StatefulWidget {
  @override
  State<FilePickerDialog> createState() => _FilePickerDialogState();
}

class _FilePickerDialogState extends State<FilePickerDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  String? _filePath;
  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://job-hunt-ad8aa.appspot.com');

  Future<String?> uploadFileToFireStore(File file) async {
    try {
      Reference ref = _storage.ref().child('users/${_auth.currentUser!.uid}');

      // Determine the file type based on the file extension
      String fileType = file.path.split('.').last;
      String contentType;

      // Set the appropriate content type based on the file type
      switch (fileType) {
        case 'pdf':
          contentType = 'application/pdf';
          break;
        case 'doc':
        case 'docx':
          contentType = 'application/msword';
          break;
        // Add more cases for other file types if needed
        default:
          contentType = 'application/octet-stream'; // Default content type
          break;
      }

      SettableMetadata metadata = SettableMetadata(contentType: contentType);
      await ref.putFile(file, metadata);

      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> pickFile(BuildContext context) async {
    if (!mounted) {
      return;
    }
    await _getUser();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (mounted && result != null) {
        // Do something with the picked file
        setState(() {
          _filePath = result.files.first.path;
          file = File(_filePath!);
        });

        String? downloadUrl = await uploadFileToFireStore(file!);
        if (downloadUrl != null) {
          print('File uploaded successfully. Download URL: $downloadUrl');
        } else {
          print('Failed to upload file.');
        }

        print('Picked file: ${result.files.first.path}');
      } else {
        // User canceled the picker
        print('File picking canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(
        'Add your cv :',
        style: getTitleStyle(color: AppColors.primary),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              pickFile(context); // Open the file picker
            },
            child: Text(
              'Pick a File',
              style: getBodyStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
