import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/widgets/filepicker.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/alicationsent.dart';
import 'package:job_finder/features/jobSeeker/nav.dart';

class apply extends StatefulWidget {
  const apply({super.key});

  @override
  State<apply> createState() => _applyState();
}

class _applyState extends State<apply> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply to this job',
          style: getTitleStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                label: Text('Name'),
                labelStyle: getBodyStyle(),
                hintText: 'Enter Full Name',
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.primary,
                ),
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                label: Text('Portifolio'),
                labelStyle: getBodyStyle(),
                hintText: 'Enter portifolio link',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/professional-portfolio.png',
                    width: 10,
                  ),
                ),
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                hintText: 'Wrtie Something',
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
            Row(
              children: [
                Text(
                  'Uploud your cv:',
                  style: getTitleStyle(color: AppColors.primary),
                ),
              ],
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilePickerDialog();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/cv.png',
                        width: 50,
                      ),
                      Gap(10),
                      Icon(Icons.add_circle_outline_rounded,
                          color: AppColors.primary)
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
          // showDialog
          showSentAlertDialog(context,
              title: 'done',
              ok: 'Back To Home',
              alert: 'Job Application Sent Sucsesfuly',
              Subtiltle: 'Best Of Luck!', onTap: () {
            pushWithReplacment(context, nav());
          });
        },
        text: 'Submit Application',
        bgcolor: AppColors.primary,
      ),
    );
  }
}
