import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';

class editAdmin extends StatefulWidget {
  const editAdmin({super.key});

  @override
  State<editAdmin> createState() => _editAdminState();
}

class _editAdminState extends State<editAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: getTitleStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                //controller: _nameController,
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
              Gap(10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                //controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text('Email Address'),
                  labelStyle: getBodyStyle(),
                  hintText: 'Enter Full Name',
                  prefixIcon: Icon(
                    Icons.email_outlined,
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
                //controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text('Mobile Number'),
                  labelStyle: getBodyStyle(),
                  hintText: 'Enter Full Name',
                  prefixIcon: Icon(
                    Icons.phone,
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
              Gap(40),
              CustomButton(
                text: 'Update',
                bgcolor: AppColors.primary,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
