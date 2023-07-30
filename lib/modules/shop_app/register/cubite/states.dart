import 'package:my_app/models/shop_model/login_model.dart';


abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterSuccssState extends ShopRegisterState{
  final ShopLoginModel loginModel;

  ShopRegisterSuccssState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState{
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibility extends ShopRegisterState{}