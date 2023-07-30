
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/social_model/social_login_model.dart';
import 'package:my_app/modules/social_app/social_register/cubite/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister (
      {

        required String name,
        required String email,
        required String password,
        required String phone
      })
  {
    print('hello');
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          userCreate(name: name,
                     email: email,
                     phone: phone,
                     uId: value.user!.uid);
      print(value.user!.email);
      print(value.user!.uid);
      //emit(SocialRegisterSuccssState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
      print('errorrrrrrrrrr${error.toString()}');
    });

  }
  void userCreate({
  required String name,
    required String email,
    required String phone,
    required String uId,

}){
    SocialUserModel model= SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://www.istockphoto.com/photo/studio-portrait-of-18-year-old-woman-with-brown-hair-gm1295044839-388871980',
      cover: 'https://unsplash.com/photos/2SY5YB0Szf4',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );
   FirebaseFirestore.instance.collection('users')
       .doc(uId)
       .set(
     model.toMap()).then((value) {
       emit(SocialCreateUserSuccssState());
   }).catchError((error){
     emit(SocialCreateUserErrorState(error.toString()));
   });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit( SocialRegisterChangePasswordVisibility());
  }
}