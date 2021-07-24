abstract class SocialState {}

class SocialInitState extends SocialState {}

class MainLoadingState extends SocialState{}

class MainSuccessState extends SocialState{}

class MainErrorState extends SocialState{}

class MainChangeState extends SocialState{}

class MainNewScreenState extends SocialState{}

class SocialLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {}

class SocialGetImageProfileSuccessState extends SocialState {}

class SocialGetImageProfileErrorState extends SocialState {}

class SocialGetCoverProfileSuccessState extends SocialState {}

class SocialGetCoverProfileErrorState extends SocialState {}

class SocialUploadImageProfileSuccessState extends SocialState {}

class SocialUploadImageProfileErrorState extends SocialState {}

class SocialUploadCoverProfileSuccessState extends SocialState {}

class SocialUploadCoverProfileErrorState extends SocialState {}

class SocialUpdateDataLoadingState extends SocialState {}

class SocialUpdateDataErrorState extends SocialState {}


//** POST **//

class SocialAddNewPostLoadingState extends SocialState {}

class SocialAddNewPostSuccessState extends SocialState {}

class SocialAddNewPostErrorState extends SocialState {}

class SocialAddPostImageErrorState extends SocialState {}

class SocialAddPostImageSuccessState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialGetPostLoadingState extends SocialState {}

class SocialGetLikePostLoadingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostErrorState extends SocialState {}

class SocialUpdatePostSuccessState extends SocialState {}

class SocialUpdatePostErrorState extends SocialState {}

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {}

//message

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessagesSuccessState extends SocialState {}

class SocialGetMessagesErrorState extends SocialState {}