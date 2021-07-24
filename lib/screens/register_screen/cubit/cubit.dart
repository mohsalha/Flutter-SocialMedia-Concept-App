import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/register_screen/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool visibility = true;

  bool visibilityConfirm = true;

  // UserModel userModel = UserModel();

  void changeVisibility() {
    visibility = !visibility;
    emit(RegisterChangeState());
  }

  void changeVisibilityConfirm() {
    visibilityConfirm = !visibilityConfirm;
    emit(RegisterChangeConfirmState());
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('user is : ${value.user}');
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((e) {
      print('register error $e');
      emit(RegisterErrorState(e.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel createUser = UserModel(
      name: name,
      uId: uId,
      email: email,
      phone: phone,
      image: 'https://img.freepik.com/free-photo/displeased-young-european-woman-with-natural-fair-curly-hair-purses-lips-feels-frustrated-being-disappointed-by-something-makes-unhappy-offended-grimace-wears-yellow-formal-costume-stands-indoor_273609-49420.jpg',
      bio: '',
      cover: 'https://img.freepik.com/free-photo/cute-female-student-sitting-floor-with-crossed-feet_176420-20216.jpg',
    );
    emit(CreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(createUser.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((e) {
      print('create user error $e');
      emit(CreateUserErrorState(e.toString()));
    });
  }
}
