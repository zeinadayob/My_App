import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/shared/components/components.dart';

import '../../../layout/social_app/cubite/cubite.dart';
import '../../../layout/social_app/cubite/states.dart';

class EditProfileScreen extends StatelessWidget
{
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController=TextEditingController();
  var bioController= TextEditingController();
  var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).model!;
        var profileImage =SocialCubit.get(context).profileImage;
        var coverImage =SocialCubit.get(context).coverImage;
        nameController.text= userModel.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;

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
                'Edit Profile',
              ),
              actions:
              [
                defualtTextButton(
                  function: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'Update',
                ),
                SizedBox(width: 15,)
              ],

            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:
                  [
                    if(state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    Container(
                      height: 190,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children:
                          [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children:
                                [
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only
                                          (
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        image: DecorationImage(
                                          image:coverImage ==null? NetworkImage("${userModel.cover}"):
                                          FileImage(File(coverImage!.path))
                                          as ImageProvider ,
                                          fit: BoxFit.cover,

                                        )
                                    ),

                                  ),
                                  IconButton(
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 16,
                                      ),
                                    ),)
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children:
                              [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundImage: profileImage == null? NetworkImage("${userModel.image}"): FileImage(File(profileImage!.path))
                                    as ImageProvider,
                                    radius: 60,
                                  ),
                                ),
                                IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16,
                                    ),
                                  ),),
                              ],
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 20,),
                    if(SocialCubit.get(context).profileImageFile != null || SocialCubit.get(context).coverImageFile != null)
                      Row(
                        children:
                        [
                          if(SocialCubit.get(context).profileImageFile != null)
                            Expanded
                              (child: Column(
                              children: [
                                defaultButton(function: ()
                                {
                                  SocialCubit.get(context).upLoadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                    text: 'upload profile'),
                                SizedBox(height: 5,),
                                if(state  is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            )),
                          SizedBox(width: 5,),
                          if(SocialCubit.get(context).coverImageFile != null)
                            Expanded
                              (child: Column(
                              children: [
                                defaultButton(function: ()
                                {
                                  SocialCubit.get(context).upLoadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                    text: 'upload cover '),
                                SizedBox(height: 5,),
                                if(state  is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            )),
                        ],
                      ),
                    SizedBox(height: 20,),
                    defaultFormField(
                      controller: nameController,

                      validator: ( String? Value)
                      {
                        if(Value!.isEmpty)
                        {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),

                    SizedBox(height:10 ,),
                    defaultFormField(
                      controller: bioController,

                      validator: ( String? Value)
                      {
                        if(Value!.isEmpty)
                        {
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: Icons.info_outline,
                    ),
                    SizedBox(height:10 ,),
                    defaultFormField(
                      controller: phoneController,

                      validator: ( String? Value)
                      {
                        if(Value!.isEmpty)
                        {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                  ],
                ),

              ),
            )
        );
      },
    );
  }
}

