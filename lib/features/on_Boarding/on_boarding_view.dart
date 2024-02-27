import 'package:flutter/material.dart';

import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/on_Boarding/on_boarding_modle.dart';
import 'package:job_finder/features/on_Boarding/welcome_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  int currentpage = 0;
  var pagecontroler = PageController();
  List<boardingModel> pages = [
    boardingModel(
        image: 'assets/images/jobSearch.svg',
        title: 'Search For Jobs in An easier and More effective way'),
    boardingModel(
        image: 'assets/images/apply.svg',
        title: 'Apply For Jobs Anywhere & Anytime'),
    boardingModel(
        image: 'assets/images/dreamJob.svg',
        title: 'Your Dream Job is Waiting For You'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                pushWithReplacment(context, welcome());
              },
              child: Text(
                'Skip',
                style: getTitleStyle(color: AppColors.primary),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                });
              },
              controller: pagecontroler,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      pages[index].image,
                      height: 400,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      pages[index].title,
                      style:
                          getTitleStyle(color: AppColors.primary, fontSize: 20),
                    ),
                  ],
                );
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  SmoothPageIndicator(
                      effect: WormEffect(
                          activeDotColor: AppColors.primary,
                          dotColor: AppColors.grey,
                          dotHeight: 12,
                          dotWidth: 20),
                      controller: pagecontroler,
                      count: 3),
                  Spacer(),
                  if (currentpage == 2)
                    CustomButton(
                      bgcolor: AppColors.primary,
                      width: 100,
                      onTap: () {
                        pushWithReplacment(context, welcome());
                      },
                      text: 'Lets Start',
                      style: getBodyStyle(
                          color: AppColors.lightblue,
                          fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
