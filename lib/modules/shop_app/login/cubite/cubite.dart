
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_model/login_model.dart';
import 'package:my_app/modules/shop_app/login/cubite/states.dart';
import 'package:my_app/shared/network/end_points.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel ?loginModel;
  void userLogin ({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadState());
    DioHelper.postData(url: LOGIN,
        data: {
          'email':email,
          'password':password,

        }).then((value) async {
      print(value.data);

      loginModel= await ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccssState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=false;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit( ShopChangePasswordVisibility ());
  }
}