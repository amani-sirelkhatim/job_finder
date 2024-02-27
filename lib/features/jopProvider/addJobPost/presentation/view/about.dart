import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jopProvider/addJobPost/presentation/view/skillsneded.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  int selectedOptiononline = -1;
  CountryCode _selectedCode = CountryCode.fromCode('US');
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
                      name: 'About the Job:',
                      color: AppColors.primary,
                      size: 20),
                ],
              ),
              Gap(10),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'explane the job',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.primary))),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: label(
                          name: 'Salary:', color: AppColors.primary, size: 20)),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'write the salary',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: AppColors.primary))),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                children: [
                  label(name: 'Country:', color: AppColors.primary, size: 20),
                  Gap(60),
                  CountryCodePicker(
                    onChanged: (CountryCode code) {
                      setState(() {
                        _selectedCode = code;
                      });
                    },
                    initialSelection: 'eg',
                    favorite: ['US', 'CA', 'GB', 'FR', 'DE'],
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: false,
                  ),
                ],
              ),
              Gap(20),
              Row(
                children: [
                  label(name: 'Job Type:', color: AppColors.primary, size: 20),
                ],
              ),
              ListTile(
                title: Text('Online', style: getBodyStyle(fontSize: 18)),
                leading: Radio<int>(
                  value: 1,
                  groupValue: selectedOptiononline,
                  activeColor: AppColors
                      .primary, // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(
                      AppColors.primary), // Change the fill color when selected
                  splashRadius: 20, // Change the splash radius when clicked
                  onChanged: (int? value) {
                    setState(() {
                      selectedOptiononline = value!;
                      print(selectedOptiononline);
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'Offline',
                  style: getBodyStyle(fontSize: 18),
                ),
                leading: Radio<int>(
                  value: 2,
                  groupValue: selectedOptiononline,
                  activeColor: AppColors
                      .primary, // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(
                      AppColors.primary), // Change the fill color when selected
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (int? value) {
                    setState(() {
                      selectedOptiononline = value!;
                    });
                  },
                ),
              ),
              if (selectedOptiononline == 2)
                Column(
                  children: [
                    Row(
                      children: [
                        label(
                            name: 'Address:',
                            color: AppColors.primary,
                            size: 20),
                      ],
                    ),
                    Gap(20),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'write the Address',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: AppColors.primary))),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          text: 'Next',
          bgcolor: AppColors.primary,
          onTap: () {
            push(context, skillsNeeded());
          },
        ),
      ),
    );
  }
}
