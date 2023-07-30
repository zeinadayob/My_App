
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/News_app/Cubit/cubite.dart';
import 'package:my_app/layout/News_app/Cubit/states.dart';
import 'package:my_app/modules/shop_app/search/search_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/cubites/cubite.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',

            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                      Icons.search
                  )),
              IconButton(
                  onPressed: ()
                  {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  )),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index)
            {
              cubit.ChangeBottomNavBar(index);
            },
            items: cubit.bottomItem
            ,
          ),

        );
      },
    );
  }
}
