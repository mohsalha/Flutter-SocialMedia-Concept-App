import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/login_screen/cubit/states.dart';
import 'package:social_app/models/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool visibility = true;
  late UserModel createUser;

  // late UserModel userModel = UserModel();

  void changeVisibility() {
    visibility = !visibility;
    emit(LoginChangeState());
  }

  void loginUser({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print('${value.user}');
          emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((e) {
      print('login error $e');
      emit(LoginErrorState(e.toString()));
    });
  }
}
