import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/layout/cubit/state.dart';
import 'package:login_screen/modules/bussiness/business_screen.dart';
import 'package:login_screen/modules/science/science_screen.dart';
import 'package:login_screen/modules/sports/sports_screen.dart';
import 'package:login_screen/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=> BlocProvider.of(context);


  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem =
  [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),

  ];
  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void ChangeBottomNavBar(int index)
  {
    currentIndex = index;
    if( index == 1)
      getSports();
    if( index == 2)
      getScience();
    emit(NewsBottomNavState());

  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '7edcc42efad74249984ced83f05c8cf4',
        }
    ).then((value)
    {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];
  void getSports()
  {
    emit(NewsLoadingSportsState());
    if(Sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'eg',
              'category': 'sports',
              'apiKey': '7edcc42efad74249984ced83f05c8cf4',
            }
        ).then((value)
        {
          //print(value.data.toString());
          Sports = value.data['articles'];
          print(Sports[0]['title']);
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });

      } else
        {
          emit(NewsGetSportsSuccessState());

        }

  }

  List<dynamic> Science = [];
  void getScience()
  {
    emit(NewsLoadingScienceState());
    if(Science.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'eg',
              'category': 'science',
              'apiKey': '7edcc42efad74249984ced83f05c8cf4',
            }
        ).then((value)
        {
          //print(value.data.toString());
          Science = value.data['articles'];
          print(Science[0]['title']);
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });

      } else
        {
          emit(NewsGetScienceSuccessState());

        }

  }
  bool isDarkMode = false;

  void ChangeAppMode()
  {
    isDarkMode = !isDarkMode;
    emit(AppChangeMode());
  }
}
