import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/auth/data/specs.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/classskill.dart';

class skils extends StatefulWidget {
  const skils({super.key});

  @override
  State<skils> createState() => _skilsState();
}

class _skilsState extends State<skils> {
  Future<void> deleteDocument({required String skill}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userskills')
          .doc(user!.email) // Replace with your user ID
          .collection('skills')
          .where('name', isEqualTo: skill)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController skillcontroler = TextEditingController();
  int skillCounter = 1;
  Future<void> addSkillToFirestore(String skillName) async {
    final CollectionReference skillsCollection = FirebaseFirestore.instance
        .collection('userskills')
        .doc(user!.email)
        .collection('skills');

    // Add the skill to Firestore with an automatically generated document ID
    await skillsCollection.add({
      'name': skillName,
      // Add more fields based on your Skill model
    });

    // Optionally, you can clear the text field after adding the skill
    skillcontroler.clear();
  }

  List<Skill> skills = []; // List to store entered skills
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  int defaultChoiceIndex1 = -1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userskills')
            .doc(user!.email)
            .collection('skills')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('add your skills '),
            );
          }
          var userData = snapshot.data?.docs;
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ExpandablePanel(
                header: Row(
                  children: [
                    label(name: 'Skills', color: AppColors.black, size: 20),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: Icon(
                          Icons.add_outlined,
                          color: AppColors.primary,
                        ))
                  ],
                ),
                collapsed: SizedBox(),
                expanded: (userData != null && userData.isNotEmpty)
                    ? SizedBox(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var skill = userData[index].data()
                                  as Map<String, dynamic>;
                              return Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.primary.withOpacity(.1)),
                                  child: Row(
                                    children: [
                                      Text(
                                        skill['name'],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SimpleDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    backgroundColor:
                                                        AppColors.white,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Gap(20),
                                                            Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              'Are you sure you want to Delete this skill??',
                                                              style: getTitleStyle(
                                                                  fontWeight:
                                                                      FontWeight
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
                                                                    text:
                                                                        'cancel',
                                                                    bgcolor:
                                                                        AppColors
                                                                            .lightgreen),
                                                                Gap(20),
                                                                CustomButton(
                                                                    onTap: () {
                                                                      deleteDocument(
                                                                          skill:
                                                                              skill['name']);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    text:
                                                                        'Delete',
                                                                    bgcolor:
                                                                        Colors
                                                                            .red)
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 15,
                                            color: Colors.red.withOpacity(.8),
                                          ))
                                    ],
                                  )
                                  // child: ,
                                  );
                            },
                            separatorBuilder: (context, index) => Gap(10),
                            itemCount: userData!.length),
                      )
                    : Center(
                        child: Text(
                          ' please add your skills',
                          style: getBodyStyle(color: AppColors.primary),
                        ),
                      ),
              ),
            ]),
          );
        });
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
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'New Skill',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: skillcontroler,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Skill'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your skill';
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
                        if (_formKey.currentState!.validate()) {
                          addSkillToFirestore(skillcontroler.text);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
