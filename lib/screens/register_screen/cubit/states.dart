
class RegisterState {}

class RegisterInitState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends RegisterState {}

class CreateUserSuccessState extends RegisterState {}

class CreateUserErrorState extends RegisterState {
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangeState extends RegisterState {}

class RegisterChangeConfirmState extends RegisterState {}

class RegisterVerifyPasswordState extends RegisterState {}