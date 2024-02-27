import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';
import 'package:job_finder/features/auth/data/specs.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:job_finder/features/jobSeeker/nav.dart';
import 'package:job_finder/features/on_Boarding/welcome_view.dart';

class complete_regestration extends StatefulWidget {
  const complete_regestration({super.key});

  @override
  State<complete_regestration> createState() => _complete_regestrationState();
}

class _complete_regestrationState extends State<complete_regestration> {
  int defaultChoiceIndex1 = -1;
  int defaultChoiceIndex2 = -1;
  int selectedOptiononline = 0;
  late String status;
  late String speclization;
  late String jobtiltle;
  @override
  void initState() {
    super.initState();
    _getUser();
    defaultChoiceIndex1 = -1;
    defaultChoiceIndex2 = -1;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? selectedList = jobTitle(defaultChoiceIndex1);
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          Navigator.pop(context);
          pushWithReplacment(context, nav());
          print('Donnnneeeeeeee');
        } else if (state is UpdateErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else if (state is UpdateLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(50),
                Text('You prefer to work:',
                    style: getTitleStyle(color: AppColors.primary)),
                ListTile(
                  title: Text('Online', style: getBodyStyle(fontSize: 18)),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedOptiononline,
                    activeColor: AppColors
                        .primary, // Change the active radio button color here
                    fillColor: MaterialStateProperty.all(AppColors
                        .primary), // Change the fill color when selected
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
                    fillColor: MaterialStateProperty.all(AppColors
                        .primary), // Change the fill color when selected
                    splashRadius: 25, // Change the splash radius when clicked
                    onChanged: (int? value) {
                      setState(() {
                        selectedOptiononline = value!;
                      });
                    },
                  ),
                ),
                Gap(20),
                Text('Specializations:',
                    style: getTitleStyle(color: AppColors.primary)),
                Gap(30),
                Wrap(
                  spacing: 8,
                  children: List.generate(specs.length, (index) {
                    return ChoiceChip(
                      labelPadding: EdgeInsets.all(2.0),
                      label: Text(
                        specs[index],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      selected: defaultChoiceIndex1 == index,
                      selectedColor: AppColors.primary,
                      onSelected: (value) {
                        setState(() {
                          defaultChoiceIndex1 =
                              value ? index : defaultChoiceIndex1;
                          defaultChoiceIndex2 = -1;
                          speclization = specs![index].toString();
                          print(specs![index].toString());
                        });
                      },
                      backgroundColor: AppColors.primary.withOpacity(.1),
                      elevation: 1,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: ),
                    );
                  }),
                ),
                Gap(30),
                Text('Job Titles:',
                    style: getTitleStyle(color: AppColors.primary)),
                Gap(30),
                Wrap(
                  spacing: 8,
                  children: List.generate(selectedList?.length ?? 0, (index) {
                    return ChoiceChip(
                      labelPadding: EdgeInsets.all(2.0),
                      label: Text(
                        selectedList?[index] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      selected: defaultChoiceIndex2 == index,
                      selectedColor: AppColors.primary,
                      onSelected: (value) {
                        setState(() {
                          defaultChoiceIndex2 = -1;
                          defaultChoiceIndex2 =
                              value ? index : defaultChoiceIndex2;
                          jobtiltle = selectedList![index].toString();
                        });
                      },
                      backgroundColor: AppColors.primary.withOpacity(.1),

                      // backgroundColor: color,
                      elevation: 1,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            onTap: () {
              if (selectedOptiononline == 1) {
                setState(() {
                  status = 'online';
                });
              } else {
                setState(() {
                  status = 'offline';
                });
              }
              context.read<AuthCubit>().updateUser1(
                  uid: user!.uid.toString(),
                  uemail: user!.email.toString(),
                  status: status,
                  speclization: speclization,
                  jobtitle: jobtiltle);
            },
            text: 'Done',
            bgcolor: AppColors.primary,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
