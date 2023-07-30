abstract class SocialStates {}
class SocialInitialState extends SocialStates{}
class SocialLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNav extends SocialStates{}
class SocialNewPosts extends SocialStates{}
class SocialProfileImageSuccessState extends SocialStates{}
class SocialProfileImageErrorState extends SocialStates{}
class SocialCoverImageSuccessState extends SocialStates{}
class SocialCoverImageErrorState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

//create post
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}


class SocialPostImageSuccessState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialGetPostsLoadingState extends SocialStates{}

class SocialPostLikeSuccessState extends SocialStates{}
class SocialPostLikeErrorState extends SocialStates{}

class SocialPostCommentsSuccessState extends SocialStates{}
class SocialPostCommentsErrorState extends SocialStates{}

class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String error;
  SocialGetAllUserErrorState(this.error);
}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}