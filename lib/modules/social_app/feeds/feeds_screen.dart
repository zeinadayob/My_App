import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/social_app/cubite/cubite.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/models/social_model/post_model.dart';
import 'package:my_app/shared/stayles/colores.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).model != null,
          builder:(context)=> SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:
                      [
                        const Image(
                          image:NetworkImage('https://cdn.pixabay.com/photo/2016/03/23/04/01/woman-1274056_960_720.jpg') ,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.white
                            ),),
                        ),
                      ]

                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=> buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=> const SizedBox(
                    height: 8,
                  ),
                  itemCount:SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 10,
                )

              ],
            ),
          ) ,
          fallback: (context)=> const Center(child: CircularProgressIndicator()),

        );
      } ,

    );
  }
  Widget buildPostItem(PostModel model,context,index,) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation:5,
    margin: const EdgeInsets.symmetric(
        horizontal: 8
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25,
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children:
                     [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            height: 1.3,

                          ),

                        ),
                        SizedBox(
                          width:5 ,),
                        Icon(
                          Icons.check_circle,
                          color: defualtColor,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style:Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.3
                      ),

                    )
                  ],
                ),
              ),
              const SizedBox(width: 15,),
              IconButton(
                  onPressed: (){},
                  icon:const Icon(
                    Icons.more_horiz,
                    size: 16,
                  )),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15
            ),
            child: Container
              (
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
          ),
          Text(
            '${model.text} ',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(),
          ),
          //Padding(
           // padding: const EdgeInsetsDirectional.only(
            //  bottom: 10,
            //  top: 5,
          //  ),
           // child: Container(
             // width: double.infinity,
              //child: Wrap(
               // children:
               // [
                 // Padding(
                    //padding: const EdgeInsetsDirectional.only(
                     //   end: 6
                   // ),
                   // child: Container(
                     // height: 25,
                     // child: MaterialButton(
                       // onPressed: (){},
                       // minWidth: 1,
                       // padding: EdgeInsets.zero,
                        //child: Text(
                            //'#Software',
                            //style:Theme.of(context).textTheme.caption!.copyWith(
                           //     color: defualtColor
                         //   )
                       // ),
                     // ),
                   // ),
                 // ),

               // ],
             // ),
           // ),
         // ),
          if(model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15,

            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image:NetworkImage('${model.postImage}') ,
                    fit: BoxFit.cover,

                  )
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical:5,

            ),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        children:
                        [
                          const Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Colors.red,

                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style:Theme.of(context).textTheme.caption!,
                          )
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          const Icon(
                            Icons.comment_rounded,
                            size: 16,
                            color: Colors.amberAccent,

                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comments',
                            style:Theme.of(context).textTheme.caption!,
                          )
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                     // SocialCubit.get(context).commentPost(SocialCubit.get(context).commentId[index]);
                    },
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                       CircleAvatar(
                        backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),
                        radius: 18,
                      ),
                      const SizedBox(width: 15,),
                      Text(
                        'write a comment..',
                        style:Theme.of(context).textTheme.caption!.copyWith(

                        ),

                      ),

                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child:Row(
                  children:
                  [
                    const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.red,

                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'like',
                      style:Theme.of(context).textTheme.caption!,
                    )
                  ],
                ),
                onTap: ()
                {

                },
              ),

            ],
          ),


        ],
      ),
    ),
  );
}
