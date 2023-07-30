
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/News_app/Cubit/states.dart';
import 'package:my_app/modules/news_app/sciences/sience_screen.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

import '../../../modules/news_app/businness/businness_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get (context) =>BlocProvider.of(context);
  int currentindex=0;
  List<BottomNavigationBarItem> bottomItem=[
    const BottomNavigationBarItem(
      icon: Icon( Icons.business,),
      label: 'Business',

    ),
    const BottomNavigationBarItem(
      icon: Icon( Icons.sports,),
      label: 'Sports',

    ),
    const BottomNavigationBarItem(
      icon: Icon( Icons.science,),
      label: 'Science',

    ),

  ];
  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),

  ];
  void ChangeBottomNavBar(int index){
    currentindex= index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }
  List<dynamic> business=[];
  List<bool> businessSelectedItem=[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData
      (
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apikey':'b92d8f72088f42b1a483ca8551bfd7a9',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business=value.data['articles'];
      business.forEach((element) {
        businessSelectedItem.add(false);
      });
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });

  }
  void selectBusinessItem(index)
  {
    for( int i = 0; i < businessSelectedItem.length ; i++)
    {
      if(i == index)
        businessSelectedItem[i]= true;
      else
        businessSelectedItem[i]= false;
    }
  }

  List<dynamic> sports=[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
    {
      DioHelper.getData
        (
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'b92d8f72088f42b1a483ca8551bfd7a9',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });

    } else
    {

      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science=[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
    {
      DioHelper.getData
        (
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'b92d8f72088f42b1a483ca8551bfd7a9',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }  else
    {
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic> search=[];
  void getSearch(String ?value)
  {

    emit(NewsGetScienceLoadingState());

    search=[];
    DioHelper.getData
      (
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apikey':'b92d8f72088f42b1a483ca8551bfd7a9',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }

}