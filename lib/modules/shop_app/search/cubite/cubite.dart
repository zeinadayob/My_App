import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_model/search_model.dart';
import 'package:my_app/modules/shop_app/search/cubite/states.dart';
import 'package:my_app/shared/network/end_points.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel ? model;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
      url:SEARCH, data: {'text':text},
      token: CacheHelper.getData(key: 'token'),
    ).then((value)
    {
      model=SearchModel.fromJson(value.data);
      print(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}