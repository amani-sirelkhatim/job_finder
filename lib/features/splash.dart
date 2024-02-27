import 'package:flutter/material.dart';
import 'package:job_finder/features/on_Boarding/on_boarding_view.dart';
import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const onBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/icons/logo.json'),
      ),
    );
  }
}
