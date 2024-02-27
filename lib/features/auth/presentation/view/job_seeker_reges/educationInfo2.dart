import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/auth/data/linksmodle.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/jobTitle.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/widgets/filepicker.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/widgets/linksalert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:job_finder/features/on_Boarding/welcome_view.dart';

class reg3 extends StatefulWidget {
  const reg3({super.key});

  @override
  State<reg3> createState() => _reg3State();
}

class _reg3State extends State<reg3> {
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

  List<linksmodel> links = [];
  TextEditingController titlecon = TextEditingController();
  TextEditingController urlcon = TextEditingController();
  CountryCode _selectedCode = CountryCode.fromCode('US');
  final TextEditingController _ageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _yearController1 = TextEditingController();
    final TextEditingController _yearController2 = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              // Text(
              //   'Resume:',
              //   style: getTitleStyle(color: AppColors.primary),
              // ),
              // GestureDetector(
              //     onTap: () {
              //       pickFile(context);
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         children: [
              //           Image.asset(
              //             'assets/icons/cv.png',
              //             width: 50,
              //           ),
              //           Gap(10),
              //           Icon(Icons.add_circle_outline_rounded,
              //               color: AppColors.primary)
              //         ],
              //       ),
              //     )),
              Gap(20),
              Text(
                'Links:',
                style: getTitleStyle(color: AppColors.primary),
              ),
              if (links.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                      itemBuilder: (contex, index) {
                        final item = links[index];
                        return Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primary.withOpacity(.1)),
                          child: ListTile(
                            leading: Icon(
                              Icons.link,
                              color: AppColors.primary,
                            ),
                            title: Text(
                              ' item.title',
                              style: getBodyStyle(color: AppColors.black),
                            ),
                            subtitle: Text('item.url'),
                          ),
                        );
                      },
                      separatorBuilder: (contex, index) => Gap(20),
                      itemCount: links.length),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    showAlertDialog(context,
                        titlecon: titlecon.text, urlcon: urlcon.text);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/link.png',
                        width: 40,
                      ),
                      Gap(10),
                      Icon(Icons.add_circle_outline_rounded,
                          color: AppColors.primary)
                    ],
                  ),
                ),
              ),
              Gap(20),
              Text(
                'Images:',
                style: getTitleStyle(color: AppColors.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/photo.png',
                        width: 40,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 150,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GridTile(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary.withOpacity(.1)),
                        child: Image.asset('assets/images/verification.png'),
                      ));
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
            onTap: () {
              push(context, complete_regestration());
            },
            text: 'next',
            bgcolor: AppColors.primary),
      ),
    );
  }

  showAlertDialog(BuildContext context,
      {required String titlecon,
      required String urlcon,
      void Function()? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.white,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    'Add a link to your profile',
                    style: getTitleStyle(color: AppColors.primary),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    //controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text('website title'),
                      labelStyle: getBodyStyle(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please the title';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    //controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text('website url'),
                      labelStyle: getBodyStyle(),
                      hintText: 'Enter Your Name',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  CustomButton(
                    text: 'Add',
                    bgcolor: AppColors.primary,
                    onTap: () {
                      setState(() {
                        links.add(linksmodel(title: titlecon, url: urlcon));
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
