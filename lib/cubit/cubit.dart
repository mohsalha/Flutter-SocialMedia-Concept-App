import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/controller/app_controller.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/screens/add_post_screen/add_post_screen.dart';
import 'package:social_app/screens/main_screen/chat_screen.dart';
import 'package:social_app/screens/main_screen/home_screen.dart';
import 'package:social_app/screens/main_screen/setting_screen.dart';
import 'package:social_app/screens/main_screen/user_screen.dart';
import 'package:social_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> title = [
    'Home',
    'Chat',
    'Add New Post',
    'User',
    'Setting',
  ];
  List<Widget> screen = [
    HomeScreen(),
    ChatScreen(),
    AddPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  void changeState(int index) {
    if (index == 0) {
      getPost();
    }
    if (index == 1 || index == 3) getUsers();
    if (index == 2 ) {
      emit(MainNewScreenState());
    } else {
      currentIndex = index;
      emit(MainChangeState());
    }
  }

  UserModel? user;

  void getUserData() {
    emit(SocialLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(AppController.instance.getUId())
        .get()
        .then((value) {
      print('user data : ${value.data()}');
      user = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((e) {
      print('error get user data : $e');
      emit(SocialGetUserErrorState());
    });
  }

  File? imageProfile;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickerFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      imageProfile = File(pickerFile.path);
      emit(SocialGetImageProfileSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialGetImageProfileErrorState());
    }
  }

  File? coverProfile;

  Future<void> getCover() async {
    final pickerFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      coverProfile = File(pickerFile.path);
      emit(SocialGetImageProfileSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialGetImageProfileErrorState());
    }
  }

  String profileUrl = '';

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('image profile url : $value');
        profileUrl = value;
        imageProfile = null;

        updateUserData(
            name: name, phone: phone, bio: bio, profileImage: profileUrl);
      }).catchError((e) {
        print('error get download image $e');
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((e) {
      print('error upload image profile $e');
      emit(SocialUploadImageProfileErrorState());
    });
  }

  String coverUrl = '';

  void uploadProfileCover({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverProfile!.path).pathSegments.last}')
        .putFile(coverProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('image cover url : $value');
        coverUrl = value;
        coverProfile = null;

        updateUserData(
            name: name, phone: phone, bio: bio, coverImage: coverUrl);
      }).catchError((e) {
        print('error get download image $e');
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((e) {
      print('error upload image profile $e');
      emit(SocialUploadImageProfileErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String profileImage = '',
    String coverImage = '',
  }) {
    print('aaaaaaaaa');
    emit(SocialUpdateDataLoadingState());
    if (coverProfile != null && imageProfile != null) {
      uploadProfileCover(name: name, phone: phone, bio: bio);
      userUpdateData(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: profileImage,
          coverImage: coverImage);

      return;
    } else if (imageProfile != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
      userUpdateData(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: profileImage,
          coverImage: coverImage);

      return;
    } else if (coverProfile != null) {
      uploadProfileCover(name: name, phone: phone, bio: bio);
      userUpdateData(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: profileImage,
          coverImage: coverImage);

      coverProfile = null;

      return;
    }
    userUpdateData(
        name: name,
        phone: phone,
        bio: bio,
        profileImage: profileImage,
        coverImage: coverImage);
  }

  void userUpdateData({
    required String name,
    required String phone,
    required String bio,
    String profileImage = '',
    String coverImage = '',
  }) {
    emit(SocialUpdateDataLoadingState());

    UserModel createUser = UserModel(
      name: name,
      uId: user!.uId,
      email: user!.email,
      phone: phone,
      bio: bio,
      image: profileImage == '' ? user!.image : profileImage,
      cover: coverImage == '' ? user!.cover : coverImage,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uId)
        .update(createUser.toMap())
        .then((value) {
      print('i\m here');
      getUserData();
    }).catchError((e) {
      print('error update data $e');
      emit(SocialUpdateDataErrorState());
    });
  }

  //** POST **//

  File? postImage;

  Future<void> getPostImage() async {
    final pickerFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialAddPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialAddPostImageErrorState());
    }
  }

  String postImageUrl = '';

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialAddNewPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('post Image url : $value');
        postImageUrl = value;
        postImage = null;
        addNewPost(
          postImage: value,
          dateTime: dateTime,
          text: text,
        );
      }).catchError((e) {
        print('error get download image $e');
        emit(SocialAddPostImageErrorState());
      });
    }).catchError((e) {
      print('error upload image profile $e');
      emit(SocialAddPostImageErrorState());
    });
  }

  void addNewPost({
    required String text,
    required String dateTime,
    String postImage = '',
  }) {
    emit(SocialAddNewPostLoadingState());

    PostModel postModel = PostModel(
      name: user!.name,
      uId: user!.uId,
      image: user!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage != '' ? postImage : '',
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uId)
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      print('i\m here');

      emit(SocialAddNewPostSuccessState());
    }).catchError((e) {
      print('error update data $e');
      emit(SocialAddNewPostErrorState());
    });
    getPost();
  }

  void removePhoto() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];

  void getPost() {
    print('first post');
    emit(SocialGetPostLoadingState());
    //   FirebaseFirestore.instance
    //       .collection('user')
    //       .doc(user.uId)
    //       .collection('posts')
    //       // .orderBy('dateTime')
    //       .snapshots()
    //       .listen((event) {
    //     posts = [];
    //     postsId = [];
    //     likes = [];
    //     event.docs.forEach((element) {
    //       emit(SocialGetLikePostLoadingState());
    //       element.reference.collection('likes').get().then(
    //         (value) {
    //           likes.add(value.docs.length);
    //           postsId.add(element.id);
    //           posts.add(
    //             PostModel.fromJson(
    //               element.data(),
    //             ),
    //           );
    //           emit(SocialGetPostSuccessState());
    //         },
    //       );
    //     }
    //   );
    // });
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uId)
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      print('inside post');

      posts = [];

      value.docs.forEach((element) {
        posts.add(
          PostModel.fromJson(
            element.data(),
          ),
        );
        emit(SocialGetPostSuccessState());
      });
      print('posts is : $posts');
    }).catchError((e) {
      print('error get post data : $e');
      emit(SocialGetPostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('postsAllUsers')
        .doc(postId)
        .collection('likes')
        .doc(AppController.instance.getUId())
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((e) {
      print('like post error $e');
      emit(SocialLikePostErrorState());
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != user!.uId)
            users.add(
              UserModel.fromJson(
                element.data(),
              ),
            );
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((e) {
        print('error get all user $e');
        emit(SocialGetAllUserErrorState());
      });
  }

  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
        senderId: user!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((e) {
      print('error send message $e');
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(user!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((e) {
      print('error send message $e');
      emit(SocialSendMessageErrorState());
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.currentUser;
    posts = [];
    users = [];
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

//posts finished

}
