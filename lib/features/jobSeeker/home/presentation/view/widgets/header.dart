import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/widgets/filter.dart';
import 'package:job_finder/features/jobSeeker/search/search.dart';

class header extends StatefulWidget {
  const header({super.key});

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  bool blur = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 370,
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroung.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Welcome, Amani',
                            style: getTitleStyle(
                                color: AppColors.white.withOpacity(.7),
                                fontSize: 20),
                          ),
                          Gap(5),
                          Image.asset('assets/icons/wave.png', width: 25)
                        ],
                      ),
                      Text(
                        'Let\'s find a job',
                        style:
                            getTitleStyle(color: AppColors.white, fontSize: 30),
                      ),
                    ],
                  ),
                  Gap(60),

                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/bell.png',
                      width: 25,
                      color: AppColors.white,
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        blur = true;
                      });
                      showBottomSheet(
                          context: context,
                          enableDrag: false,
                          builder: (BuildContext context) {
                            return SizedBox(
                              //  height: 600,
                              child: Container(
                                height: 580,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    color: AppColors.white),
                                child: Column(
                                  children: [
                                    Gap(5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.cancel_outlined,
                                              color: AppColors.primary),
                                          onPressed: () {
                                            setState(() {
                                              blur = false;
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                        Gap(20)
                                      ],
                                    ),
                                    const filter()
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 25,
                      color: AppColors.white,
                    ),
                  )
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.notifications,
                  //       color: AppColors.white,
                  //     )),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.filter_list_sharp,
                  //       color: AppColors.white,
                  //     ))
                ],
              ),
            ),
            Positioned(
                top: 150,
                left: 30,
                child: Container(
                  padding: EdgeInsets.all(30),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: [
                      Gap(20),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: 'Search for a job title',
                          hintStyle: getBodyStyle(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 2.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.1), width: 2.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Gap(20),
                      CustomButton(
                          onTap: () {
                            push(context, search());
                          },
                          width: double.infinity,
                          text: 'Search',
                          bgcolor: AppColors.primary)
                    ],
                  ),
                )),
            blur == true
                ? Container(
                    height: 200,
                    color: AppColors.black.withOpacity(.8),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
