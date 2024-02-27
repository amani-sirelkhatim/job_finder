import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/features/jopProvider/addJobPost/presentation/view-model/post_Job_states.dart';

class PostJobCubit extends Cubit<PostJobStates> {
  PostJobCubit() : super(PostJobInitState());

  PostJob({
    required String useremail,
    required String userid,
    required String speclization,
    required String jobtitle,
  }) async {
    emit(PostJobLoadingState());
    try {
      // firestore
      FirebaseFirestore.instance
          .collection('jobs')
          .doc(userid)
          .collection('maininfo')
          .doc(useremail)
          .set({
        'speclization': speclization,
        'jobtitle': jobtitle,
        'postedby': useremail,
        'about': null,
        'salary': null,
        'country': null,
        'type': null,
      }, SetOptions(merge: true));
      emit(PostJobSuccessState());
    } catch (e) {
      emit(PostJobErrorState(error: 'incaontered a proplem try again later!!'));
    }
  }
}
