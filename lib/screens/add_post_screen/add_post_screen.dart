import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/size_config.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(20),
                color: Colors.black,
              ),
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(10)),
                child: TextButton(
                  onPressed: () {
                   var i =  MediaQuery.of(context).viewInsets.bottom;
print(i.toString());
                    var now = DateTime.now();
                    if (cubit.postImage != null) {
                      cubit
                          .uploadPostImage(
                        text: _postController.text,
                        dateTime: now.toString(),
                      );
                      _postController.text = '';

                    } else {
                      cubit
                          .addNewPost(
                        text: _postController.text,
                        dateTime: now.toString(),
                      );
                      _postController.text = '';

                    }
                  },
                  child: Text(
                    'POST',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(18),
                      color: defaultColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(SizeConfig.scaleHeight(20)),
            child: Column(
              children: [
                if (state is SocialAddNewPostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialAddNewPostLoadingState)
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${cubit.user.image}',
                      ),
                      backgroundColor: defaultColor,
                      radius: 30,
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(15),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${cubit.user.name}',
                                style: TextStyle(
                                  fontSize: SizeConfig.scaleTextFont(14),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(5),
                              ),
                              Icon(
                                Icons.verified,
                                color: defaultColor,
                                size: SizeConfig.scaleHeight(15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    scrollPhysics: BouncingScrollPhysics(),
                    controller: _postController,
                    decoration: InputDecoration(
                      hintMaxLines: 4,
                      border: InputBorder.none,
                      hintText:
                          'What\'s in your mind? ${cubit.user.name}......',
                    ),
                  ),
                ),
                if (cubit.postImage != null && MediaQuery.of(context).viewInsets.bottom == 0)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: SizeConfig.scaleHeight(200),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePhoto();
                        },
                        icon: Icon(
                          Icons.close,
                          size: SizeConfig.scaleHeight(25),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                              size: SizeConfig.scaleHeight(20),
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(5),
                            ),
                            Text(
                              'Add Photo',
                              style: TextStyle(
                                  fontSize: SizeConfig.scaleTextFont(16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(16),
                          ),
                        ),
                      ),
                    ),
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
