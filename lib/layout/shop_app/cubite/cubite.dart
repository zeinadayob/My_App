
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/shop_app/cubite/state.dart';
import 'package:my_app/models/shop_model/categories_model.dart';
import 'package:my_app/models/shop_model/change_favorite_model.dart';
import 'package:my_app/models/shop_model/favourite_model.dart';
import 'package:my_app/models/shop_model/home_model.dart';
import 'package:my_app/models/shop_model/login_model.dart';
import 'package:my_app/modules/shop_app/favorites/favorite_screen.dart';
import 'package:my_app/modules/shop_app/products/products_screen.dart';
import 'package:my_app/modules/shop_app/setting/setting_search.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';
import 'package:my_app/shared/network/end_points.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

import '../../../modules/shop_app/categories/categories_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  HomeModel ? homeModel;
  CategoriesModel ? categoriesModel;
  ChangeFavouritesModel ? changeFavouritesModel;
  FavoritesModel ? favoritesModel;
  ShopLoginModel ? userModel;
  Map<int, bool> ?favourite = {};
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());}

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) async {

      homeModel = await HomeModel.fromJson(value.data);
      //print(homeModel.toString());

      homeModel!.data!.products.forEach((element) {
        favourite!.addAll(
            {
              element.id!: element.inFavorite!
            }
        );
      });

      print(favourite.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) async {
      categoriesModel = await CategoriesModel.fromJson(value.data);
      print(categoriesModel.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  void changeFavourites(int? productId) {
    favourite![productId!] =! favourite![productId]!;
    emit(ShopChangeFavouritesState());
    DioHelper.postData(
      url: FAVOURITES,
      data:
      {
        'product_id': productId,

      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {

      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
      print(value.data);
      if (!changeFavouritesModel!.status!) {
        favourite![productId] = !favourite![productId]!;
      }else{
        getFavorites();
      }
    }).catchError((error) {
      emit(ShopErrorChangeFavouritesState());
      print(error.toString());
    });
  }

  void getFavorites() {
    emit(ShopChangeFavouritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) async{

      favoritesModel = await FavoritesModel.fromJson(value.data!);
      print(value.data!.toString());
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      emit(ShopErrorGetFavState());
      print(error.toString());
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) async {
      userModel = await ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print(error.toString());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: CacheHelper.getData(key: 'token'),
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value) async {
      userModel = await ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });
  }

}