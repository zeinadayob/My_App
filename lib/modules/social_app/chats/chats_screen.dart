import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/models/social_model/social_login_model.dart';
import 'package:my_app/modules/social_app/chat-details/chat_details_screen.dart';
import 'package:my_app/shared/components/components.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.length > 0 ,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index)=> buildChatItem(SocialCubit.get(context).users![index],context),
              separatorBuilder: (context, index)=> myDivider(),
              itemCount: SocialCubit.get(context).users!.length),
          fallback:(context) => const Center(child: CircularProgressIndicator()) ,

        );
      },

    );
  }
  Widget buildChatItem( SocialUserModel model,context)=> InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(userModel:model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children:
         [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
            radius: 25,
          ),
          SizedBox(width: 15,),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.3,

            ),

          ),

        ],
      ),
    ),
  );



}
