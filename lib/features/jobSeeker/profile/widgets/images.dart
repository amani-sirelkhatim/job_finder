import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class images extends StatefulWidget {
  const images({super.key});

  @override
  State<images> createState() => _imagesState();
}

class _imagesState extends State<images> {
  Future<void> deleteDocument({required String image}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userimages')
          .doc(user!.email) // Replace with your user ID
          .collection('images')
          .where('imagepath', isEqualTo: image)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
        print('deleted');
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  User? user;
  String? UserID;
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  late String image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://job-hunt-ad8aa.appspot.com');
  Future<String> uploadImageToFireStore(File image) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage
          .ref()
          .child('user/Acomplishedwork/${_auth.currentUser!.uid}/$timestamp');
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();
      addimageToFirestore(imageurl: url);
      print(url);
      return url;
    } catch (e) {
      print('errorrrrrrrr :$e');
      return '';
    }
  }

  Future<void> addimageToFirestore({
    required String imageurl,
  }) async {
    try {
      final CollectionReference imagecollection = FirebaseFirestore.instance
          .collection('userimages')
          .doc(user!.email)
          .collection('images');

      // Add the skill to Firestore with an automatically generated document ID
      await imagecollection.add({
        'imagepath': imageurl,

        // Add more fields based on your Skill model
      });
      print(imageurl);
    } catch (e) {
      print(e);
    }

    // Optionally, you can clear the text field after adding the skill
  }

  UploadFromGallery() async {
    _getUser();
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        file = File(pickedfile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!);
    print('done');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ExpandablePanel(
            header: Row(
              children: [
                label(
                    name: 'Accomplished work',
                    color: AppColors.black,
                    size: 20),
                Spacer(),
                IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primary,
                    ))
              ],
            ),
            collapsed: SizedBox(),
            expanded: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userimages')
                    .doc(user?.email)
                    .collection('images')
                    .snapshots(),
                builder: (context, snapshot) {
                  print("Snapshot: $snapshot");
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Add images to your Accomplished work'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var userData = snapshot.data?.docs;
                  print("Number of Documents: ${userData!.length}");
                  return (userData.isNotEmpty)
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: userData!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // You can adjust this value based on your requirements

                            crossAxisSpacing: 10,

                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            var documentData =
                                userData![index].data() as Map<String, dynamic>;
                            var imagePath = documentData['imagepath'];

                            return Container(
                              alignment: Alignment.bottomRight,
                              height: 400,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imagePath),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.grey)),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SimpleDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            backgroundColor: AppColors.white,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Gap(20),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Are you sure you want to Delete this image ??',
                                                      style: getTitleStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    Gap(30),
                                                    Row(
                                                      children: [
                                                        CustomButton(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text: 'cancel',
                                                            bgcolor: AppColors
                                                                .lightgreen),
                                                        Gap(20),
                                                        CustomButton(
                                                            onTap: () {
                                                              deleteDocument(
                                                                  image:
                                                                      imagePath);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text: 'Delete',
                                                            bgcolor: Colors.red)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.white,
                                    child: Icon(Icons.delete,
                                        size: 15,
                                        color: Colors.red.withOpacity(.8)),
                                  )),
                            );
                          })
                      : Center(
                          child: Text(
                            '  add your images',
                            style: getBodyStyle(color: AppColors.primary),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, {void Function()? onTap}) {
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
              height: 150,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    'New image',
                    style: getTitleStyle(color: AppColors.primary),
                  ),
                  const SizedBox(height: 20),
                  Gap(10),
                  CustomButton(
                    text: 'Add',
                    bgcolor: AppColors.primary,
                    onTap: () {
                      UploadFromGallery();
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
