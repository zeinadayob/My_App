abstract class SocialLoginState{}

class SocialLoginInitialState extends SocialLoginState{}

class SocialLoginLoadState extends SocialLoginState{}

class SocialLoginSuccssState extends SocialLoginState {
  final String uId;
  SocialLoginSuccssState(this.uId);
}

class SocialLoginErrorState extends SocialLoginState{
  final error;

  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibility extends SocialLoginState{}