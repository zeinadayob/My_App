
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_model/login_model.dart';
import 'package:my_app/modules/shop_app/register/cubite/states.dart';
import 'package:my_app/shared/network/end_points.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel ? loginModel;
  void userRegister (
      {

        required String name,
        required String email,
        required String password,
        required String phone
      })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,

        }).then((value) {
      print(value.data);

      loginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccssState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit( ShopRegisterChangePasswordVisibility());
  }
}