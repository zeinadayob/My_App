import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/shared/components/components.dart';

import '../../../shared/stayles/colores.dart';

class NewPostsScreen extends StatelessWidget {
  NewPostsScreen({Key? key}) : super(key: key);
 var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar:  AppBar(
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: const Icon(
                  Icons.arrow_back_outlined
              ),
            ),
            title: const Text(
              'Create Post',

            ),
            actions:
            [
              defualtTextButton(
                function: ()
                {
                  var now= DateTime.now();
                  if(SocialCubit.get(context).postImageFile==null)
                  {
                    SocialCubit.get(context).createPost(dateTime: now.toString(), text: textController.text);
                  }else
                  {
                    SocialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                  }
                },
                text: 'Posts',
              ),
            ],

          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children:
              [
                if( state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children:
                  const [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/03/23/04/01/woman-1274056_960_720.jpg'),
                      radius: 25,
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child:Text(
                        'Zeina Dayob',
                        style: TextStyle(
                          height: 1.3,

                        ),

                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind..',
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImageFile !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:
                  [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(4),

                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postImageFile!),
                            fit: BoxFit.cover,

                          )
                      ),

                    ),
                    IconButton(
                      onPressed: ()
                      {
                       SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),)
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                        SocialCubit.get(context).getPostImage();
                      },
                          child: Row(
                            children:
                            const [
                              Icon(
                                  Icons.image,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                'Add photo'
                              ),
                            ],
                          ),),
                    ),
                    TextButton(
                        onPressed: (){},
                        child: const Text(
                          '# tags',
                        )
                    )

                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
