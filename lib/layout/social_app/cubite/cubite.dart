import 'dart:io';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/layout/social_app/cubite/states.dart';
import 'package:my_app/models/social_model/message_model.dart';
import 'package:my_app/models/social_model/post_model.dart';
import 'package:my_app/models/social_model/social_login_model.dart';
import 'package:my_app/modules/social_app/New_posts/new_posts_screen.dart';

import 'package:my_app/modules/social_app/chats/chats_screen.dart';
import 'package:my_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:my_app/modules/social_app/setting/settings_screen.dart';
import 'package:my_app/modules/social_app/users/users_screen.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  SocialUserModel? model;

  static SocialCubit get(context) => BlocProvider.of(context);


  void getUserData() {
    emit(SocialLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('eeerroor${error.toString()}');
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index ==1)
      getUsers();
    if (index == 2)
      emit(SocialNewPosts());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  XFile? profileImage;
  File ? profileImageFile;

  final ImagePicker picker = ImagePicker();

  Future <void> getProfileImage() async
  {
    final XFile? profileImage = await picker.pickImage(
        source: ImageSource.gallery);
    if (profileImage != null) {
      final File? profileImageFile = File(profileImage!.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImageErrorState());
    }
  }

  XFile? coverImage;
  File? coverImageFile;

  Future <void> getCoverImage() async
  {
    final XFile? coverImage = (await picker.pickImage(
        source: ImageSource.gallery));
    if (coverImage != null) {
      final File? coverImageFile = File(coverImage.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImageErrorState());
    }
  }

  void upLoadProfileImage({
    required String ?name,
    required String ?phone,
    required String ?bio,}) async
  {
    emit(SocialUserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance.ref().child
      ('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}').
    putFile(profileImageFile!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString());
      });
    })
        .catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void upLoadCoverImage({
    required String ?name,
    required String ?phone,
    required String ?bio,
  }) async
  {
    emit(SocialUserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance.ref().child
      ('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}').
    putFile(coverImageFile!).then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print(error.toString());
      });
    })
        .catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  //void updateUserImages({
  // required String ?name,
  // required String ?phone,
  //required String ?bio,

  //}) async
  //{
  //emit(SocialUserUpdateLoadingState());
  //if(coverImageFile!=null){
  // upLoadCoverImage();
  //}else if(profileImageFile!=null)
  //{
  //upLoadProfileImage();
  //} else if(coverImageFile!=null && profileImageFile!=null)
  //{

  //}
  //else
  //{
  // updateUser(name: name, phone: phone, bio: bio);
  // }

  // }

  void updateUser({
    required String ?name,
    required String ?phone,
    required String ?bio,
    String ? cover,
    String ? image,

  }) async
  {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: model!.uId!,
      email: model!.email!,
      cover: cover ?? model!.cover!,
      image: image ?? model!.image!,
      isEmailVerified: false,

    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(SocialUserUpdateErrorState());
      print(error.toString());
    });
  }

  XFile? postImage;
  File? postImageFile;

  Future <void> getPostImage() async
  {
    final XFile? postImage = (await picker.pickImage(
        source: ImageSource.gallery));
    if (postImage != null) {
      final File? postImageFile = File(postImage.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }
  }


  void createPost({
    required String ? dateTime,
    required String ? text,
    String? postImage,

  }) async
  {
    PostModel userModel = PostModel(
      name: model!.name!,
      uId: model!.uId!,
      image: model!.image!,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',


    );

    await FirebaseFirestore.instance
        .collection('posts')
        .add(userModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }

  void uploadPostImage({
    required String ? dateTime,
    required String ? text,
  }) async
  {
    emit(SocialCreatePostLoadingState());
    await firebase_storage.FirebaseStorage.instance.ref().child
      ('posts/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}').
    putFile(coverImageFile!).then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      });
    })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }
  void removePostImage()
  {
    postImageFile= null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts=[];
  List<int> likes=[];
  List<String> postsId=[];
  List<int> comments=[];
  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts').get()
        .then((value){
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get().then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
                .catchError((error){});

          });
          emit(SocialGetPostsSuccessState());
    })
        .catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
          print(error.toString());
    });
  }
  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(model!.uId)
        .set({
      'like':true
    })
        .then((value) {
          emit(SocialPostLikeSuccessState());
    })
        .catchError((error){
          emit(SocialPostLikeErrorState());
    });
  }
  void commentPost(String commentId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc(model!.uId)
        .set({
      'comments': true
    })
        .then((value){
          emit(SocialPostCommentsSuccessState());
    })
        .catchError((error){
          emit(SocialPostCommentsErrorState());
    });
  }
  List<SocialUserModel> ? users;
  void getUsers()
  {
    users=[];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance
        .collection('users').get()
        .then((value){
      value.docs.forEach((element) {
        if(element.data() ['uId'] != model!.uId)
        users!.add(SocialUserModel.fromJson(element.data()));

      });
      emit(SocialGetAllUserSuccessState());
    })
        .catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
      print(error.toString());
    });
  }
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,

})
  {
    MessageModel model1 =MessageModel(
      text: text,
      receiverId: receiverId,
      dateTime: dateTime,
      senderId: model!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model1.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
          emit(SocialSendMessageErrorState());
          print(error.toString());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(model1.toMap())
        .then((value) {
      emit(SocialGetMessageSuccessState());
    })
        .catchError((error){
      emit(SocialGetMessageErrorState());
      print(error.toString());
    });

  }
  List<MessageModel> messages=[];
  void getMessages({
    required String receiverId,})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
       messages=[];
       event.docs.forEach((element)
       {
         messages.add(MessageModel.fromJson(element.data()));
       });
       emit(SocialGetMessageSuccessState());
    });
  }
}