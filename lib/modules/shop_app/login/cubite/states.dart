

import 'package:my_app/models/shop_model/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadState extends ShopLoginState{}

class ShopLoginSuccssState extends ShopLoginState{
  final ShopLoginModel loginModel;
  ShopLoginSuccssState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{}

class ShopChangePasswordVisibility extends ShopLoginState{}