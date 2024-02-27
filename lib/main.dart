import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD4wtV2GmpJw-Gvq5RdmIMkVAv0juoJAgc",
          appId: "com.example.job_finder",
          messagingSenderId: "1041053308872",
          projectId: "job-hunt-ad8aa"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: splash()),
    );
  }
}
