import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/models/social_model/message_model.dart';
import 'package:my_app/models/social_model/social_login_model.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/stayles/colores.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel ? userModel;
  ChatDetailsScreen({this.userModel});
  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(width: 15,),
                    Text('${userModel!.name}',),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0 ,
                builder: (context)=>  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children:
                    [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                            var message= SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).model!.uId== message.senderId)
                              {
                                return  buildMyMessage(message);
                              }
                              else
                              {
                                return buildMessage(message);
                              }
                            },

                            separatorBuilder: (context, index)=> SizedBox(height: 15,),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white24,
                              width: 1

                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController ,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here...',


                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: defualtColor,
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: ()
                                {
                                  SocialCubit.get(context).sendMessage
                                    (receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text:messageController.text,
                                  );
                                },
                                child:const Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ) ,),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context)=> Center(child: CircularProgressIndicator()),

              ),
            );
          },

        );
      },

    );
  }
  Widget buildMessage(MessageModel model)=>  Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],

          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child:  Text(
          '${model.text}'),
    ),
  );
  Widget buildMyMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defualtColor.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
          '${model.text}'),
    ),
  );
}
