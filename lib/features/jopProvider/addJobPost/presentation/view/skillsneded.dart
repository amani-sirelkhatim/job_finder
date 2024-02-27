import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/auth/data/specs.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/alicationsent.dart';
import 'package:job_finder/features/jopProvider/admin_nav.dart';
import 'package:job_finder/features/jopProvider/home/adminhome.dart';

class skillsNeeded extends StatefulWidget {
  const skillsNeeded({super.key});

  @override
  State<skillsNeeded> createState() => _skillsNeededState();
}

class _skillsNeededState extends State<skillsNeeded> {
  TextEditingController rescon = TextEditingController();
  List<String> responcibilities = [];
  TextEditingController skillcon = TextEditingController();
  List<String> skills = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  label(
                      name: 'Skills Nedded :',
                      color: AppColors.primary,
                      size: 20),
                  IconButton(
                      onPressed: () {
                        showAlertDialog(context, type: 1);
                      },
                      icon: Icon(
                        Icons.add_outlined,
                        color: AppColors.primary,
                      ))
                ],
              ),
              if (skills.isNotEmpty)
                SizedBox(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (contex, index) {
                        final item = skills[index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primary.withOpacity(.1)),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/icons/skill-development.png',
                              width: 30,
                            ),
                            title: Text(
                              skills[index].toString(),
                              style: getBodyStyle(color: AppColors.black),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (contex, index) => Gap(20),
                      itemCount: skills.length),
                ),
              Gap(30),
              Row(
                children: [
                  label(
                      name: 'Resposibilities:',
                      color: AppColors.primary,
                      size: 20),
                  IconButton(
                      onPressed: () {
                        showAlertDialog(context, type: 2);
                      },
                      icon: Icon(
                        Icons.add,
                        color: AppColors.primary,
                      ))
                ],
              ),
              if (responcibilities.isNotEmpty)
                SizedBox(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (contex, index) {
                        final item = responcibilities[index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primary.withOpacity(.1)),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/icons/accept.png',
                              width: 30,
                            ),
                            title: Text(
                              responcibilities[index].toString(),
                              style: getBodyStyle(color: AppColors.black),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (contex, index) => Gap(20),
                      itemCount: responcibilities.length),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          text: 'Done',
          bgcolor: AppColors.primary,
          onTap: () {
            showSentAlertDialog(context,
                title: 'done',
                ok: 'Back To Home',
                alert: 'Job Post Sent Sucsesfuly',
                Subtiltle: 'Best Of Luck!', onTap: () {
              pushWithReplacment(context, adminNav());
            });
          },
        ),
      ),
    );
  }

  showAlertDialog(
    BuildContext context, {
    required int type,
    void Function()? onTap,
  }) {
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
                  if (type == 1)
                    Column(
                      children: [
                        Text(
                          'Add a Skill',
                          style: getTitleStyle(color: AppColors.primary),
                        ),
                        const SizedBox(height: 20),
                        Gap(20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: skillcon,
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
                            setState(() {
                              skills.add(skillcon.text);
                              skillcon.clear();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  if (type == 2)
                    Column(
                      children: [
                        Text(
                          'Add a Responsibility',
                          style: getTitleStyle(color: AppColors.primary),
                        ),
                        const SizedBox(height: 20),
                        Gap(20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: rescon,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text('Responsibility'),
                            labelStyle: getBodyStyle(),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Resposibility';
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
                              responcibilities.add(rescon.text);
                              rescon.clear();
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ],
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
