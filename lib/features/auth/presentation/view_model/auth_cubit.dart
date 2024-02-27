import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  //---------------------------regester-----------------------------------//
  ///---------Admin sign up
  regestirAdmin(
      {required String name,
      required String email,
      required String Address,
      required String password,
      required String phone,
      required int type}) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      // firestore
      FirebaseFirestore.instance
          .collection('adminimages')
          .doc(user.email)
          .collection('images')
          .add({});
      FirebaseFirestore.instance
          .collection('adminlinks')
          .doc(user.email)
          .collection('links')
          .add({});
      FirebaseFirestore.instance.collection('adminmaininfo').doc(user.uid).set({
        'name': name,
        'image': null,
        'email': email,
        'phone': phone,
        'city': Address,
        'type': type,
        'about': null,
        'coverimage': null
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'الحساب موجود بالفعل'));
      }
    } catch (e) {
      emit(RegisterErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
    }
  }

//-----------------user signup-----------------
  regestirUser({
    required String name,
    required String email,
    required String Address,
    required String password,
    required String phone,
    required String birthdate,
    required String gender,
  }) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      // firestore
      FirebaseFirestore.instance
          .collection('userskills')
          .doc(user.email)
          .set({});
      FirebaseFirestore.instance
          .collection('userexperiance')
          .doc(user.email)
          .set({});
      FirebaseFirestore.instance
          .collection('userimages')
          .doc(user.email)
          .set({});
      FirebaseFirestore.instance
          .collection('userlinks')
          .doc(user.email)
          .set({});
      FirebaseFirestore.instance.collection('usermaininfo').doc(user.uid).set({
        'name': name,
        'image': null,
        'email': email,
        'phone': phone,
        'city': Address,
        'birthdate': birthdate,
        'about': null,
        'gender': gender,
        'status': null,
        'cv': null,
        'speclization': null,
        'jobtitle': null,
        'coverimage': null
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'the password is weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'this email is already regestered'));
      }
    } catch (e) {
      emit(RegisterErrorState(
          error: 'there is a problem please try again later'));
    }
  }
  //

  //----------------------------update user -------------------
  updateUser1({
    required String uid,
    required String uemail,
    required String status,
    required String speclization,
    required String jobtitle,
  }) async {
    emit(UpdateLoadingState());
    try {
      // firestore
      FirebaseFirestore.instance.collection('usermaininfo').doc(uid).set({
        'status': status,
        'speclization': speclization,
        'jobtitle': jobtitle,
      }, SetOptions(merge: true));
      emit(UpdateSuccessState());
    } catch (e) {
      emit(
          UpdateErrorState(error: 'there is a problem please try again later'));
    }
  }

//--------------------------------
  updateAboutUser({
    required String uid,
    required String uemail,
    required String about,
  }) async {
    emit(UpdateLoadingState());
    try {
      // firestore
      FirebaseFirestore.instance.collection('usermaininfo').doc(uid).set({
        'about': about,
      }, SetOptions(merge: true));
      emit(UpdateSuccessState());
    } catch (e) {
      emit(
          UpdateErrorState(error: 'there is a problem please try again later'));
    }
  }
  //-----------------------
  // Addskill({
  //   required String uid,
  //   required String uemail,
  //   required String skill,

  // }) async {
  //   emit(UpdateLoadingState());
  //   try {
  //     // firestore
  //     FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(uid)
  //         .collection('skills')
  //         .doc(uemail)
  //         .set({
  //       'status': status,
  //       'speclization': speclization,
  //       'jobtitle': jobtitle,
  //     }, SetOptions(merge: true));
  //     emit(UpdateSuccessState());
  //   } catch (e) {
  //     emit(UpdateErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
  //   }
  // }

//---------------------------login--------------------------------------//
  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        User user = credential.user!;
      }
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'wrong password'));
      } else {
        emit(LoginErrorState(
            error: 'there is a proplem in logging in pleasr try again later'));
      }
    }
  }
  //-------------------education collection-----------------------

  usereducation({
    required String userid,
    required String degree,
    required String starty,
    required String endy,
    required String inistitutionname,
    required String inistitutioncountry,
    required String email,
  }) async {
    emit(RegisterLoadingState());
    try {
      // firestore
      FirebaseFirestore.instance.collection('usereducation').doc(email).set({
        'degree': degree,
        'inistitutionname': inistitutionname,
        'inistututioncountry': inistitutioncountry,
        'startY': starty,
        'endY': endy,
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(
          error: 'there is a problem please try again later'));
    }
  }

  Updateuserprofile({
    required String uid,
    required String name,
    required String email,
    required String Address,
    required String phone,
    required String birthdate,
  }) async {
    emit(RegisterLoadingState());
    try {
      // firestore
      FirebaseFirestore.instance.collection('usermaininfo').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'city': Address,
        'birthdate': birthdate,
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(
          error: 'there is a problem please try again later'));
    }
  }
}
