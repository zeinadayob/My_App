

import 'package:my_app/models/shop_model/change_favorite_model.dart';
import 'package:my_app/models/shop_model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNav extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{

}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavouritesState extends ShopStates{
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}
class ShopChangeFavouritesState extends ShopStates{}
class ShopErrorChangeFavouritesState extends ShopStates{}
class ShopLoadingGetFavState extends ShopStates{}
class ShopSuccessGetFavState extends ShopStates{}
class ShopErrorGetFavState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel ?loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel ?loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}