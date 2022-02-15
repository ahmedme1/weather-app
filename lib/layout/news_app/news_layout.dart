import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/layout/cubit/cubit.dart';
import 'package:login_screen/layout/cubit/state.dart';
import 'package:login_screen/layout/news_app/cubit/state.dart';
import 'package:login_screen/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),

      child: BlocConsumer<NewsCubit,NewsState>(
        listener:(context , state){}  ,
        builder:  (context , state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed:()
                    {

                    }),
                IconButton(
                    icon: Icon(Icons.brightness_4_outlined),
                    onPressed:()
                    {
                      NewsCubit.get(context).ChangeAppMode();
                    }),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: ()
              {
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.deepOrange,
              currentIndex: cubit.currentIndex,
              elevation: 50,
              items: cubit.bottomItem,
              onTap: (index)
              {
                cubit.ChangeBottomNavBar(index);
              },
            ),


          );
        },

      ),

    );
  }
}
