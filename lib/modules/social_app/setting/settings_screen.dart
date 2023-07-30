import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/modules/social_app/edite_profile/edit_profile_screen.dart';

import '../../../shared/components/components.dart';


class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,stata)
      {
        var userModel =SocialCubit.get(context).model!;
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column
              (
                children:
                [
                  Container(
                    height: 190,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children:
                        [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only
                                    (
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image:NetworkImage('${userModel!.cover!}') ,
                                    fit: BoxFit.cover,

                                  )
                              ),

                            ),
                          ),
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('${userModel.image!}'),
                              radius: 60,
                            ),
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${userModel.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${userModel.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20
                    ),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '234',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '10k',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children:
                    [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: (){},
                            child:const Text('Add Photos') ),

                      ),
                      const SizedBox(width: 10,),
                      OutlinedButton(
                          onPressed: ()
                          {
                            navigateTo(context,EditProfileScreen());
                          },
                          child:const Icon(Icons.edit,
                          size: 16,) ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children:
                    [
                      OutlinedButton(
                          onPressed: ()
                          {
                            FirebaseMessaging.instance.subscribeToTopic('announcement');
                          },
                          child: const Text(
                            'subscribe'
                          ),
                      ),
                      const SizedBox(width: 20,),
                      OutlinedButton(
                        onPressed: ()
                        {
                          FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                        },
                        child: const Text(
                            'unsubscribe'
                        ),
                      ),
                    ],
                  ),


                ]
            )
        );
      },


    );
  }
}
