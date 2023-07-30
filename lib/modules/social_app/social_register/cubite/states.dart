

abstract class SocialRegisterState{}

class SocialRegisterInitialState extends SocialRegisterState{}

class SocialRegisterLoadingState extends SocialRegisterState{}

class SocialRegisterSuccssState extends SocialRegisterState{}

class SocialRegisterErrorState extends SocialRegisterState{
  final String error;

  SocialRegisterErrorState(this.error);
}


class SocialCreateUserSuccssState extends SocialRegisterState{}

class SocialCreateUserErrorState extends SocialRegisterState{
  final String error;

  SocialCreateUserErrorState(this.error);
}


class SocialRegisterChangePasswordVisibility extends SocialRegisterState{}