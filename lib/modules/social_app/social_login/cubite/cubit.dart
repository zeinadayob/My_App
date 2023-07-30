import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/social_app/social_login/cubite/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit():super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=> BlocProvider.of(context);
  //SocialLoginModel loginModel;
  void userLogin({
    required String email,
    required String password})
  {

    emit(SocialLoginInitialState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccssState(value.user!.uid));

    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibility());
  }
}