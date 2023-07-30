import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/shared/components/components.dart';

import '../../modules/social_app/New_posts/new_posts_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state){
        if(state is SocialNewPosts){
          navigateTo(context,NewPostsScreen());
        }
      } ,
      builder: (context,state){
       var cubit=SocialCubit.get(context);
        return  Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.notifications_none)),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search_outlined)),
              ],
            ),
            body: cubit.screen[cubit.currentIndex],
             bottomNavigationBar: BottomNavigationBar(
               currentIndex: cubit.currentIndex,
               onTap: (index){
                cubit.changeBottomNav(index);
               },
               items:
               [
                 BottomNavigationBarItem(
                     icon:Icon(
                       Icons.home,
                     ),
                   label: 'Home'
                 ),
                 BottomNavigationBarItem(
                   icon:Icon(
                     Icons.chat_bubble_outline,
                   ),
                   label: 'Chats'
                 ),
                 BottomNavigationBarItem(
                     icon:Icon(
                       Icons.post_add_outlined,
                     ),
                     label: 'Posts'
                 ),
                 BottomNavigationBarItem(
                   icon:Icon(
                     Icons.location_history,
                   ),
                   label: 'users'
                 ),
                 BottomNavigationBarItem(
                   icon:Icon(
                     Icons.settings,
                   ),
                   label: 'settings'
                 ),
               ],
             ),
          );
      }
      ,

    );
  }
}
