import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/size_config.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  ChatDetailsScreen(this.userModel);

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: '${userModel.uId}');
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: SizeConfig.scaleHeight(15)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${userModel.image}',
                        ),
                        backgroundColor: defaultColor,
                        radius: 20,
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(15),
                      ),
                      Text(
                        '${userModel.name}',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(20)),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var messageText =
                              SocialCubit.get(context).messages[index];
                          if (userModel.uId! == messageText.senderId) {
                            return message(messageText);
                          } else {
                            return myMessage(messageText);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: SizeConfig.scaleWidth(5),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...'),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(50),
                            child: MaterialButton(
                              color: defaultColor,
                              minWidth: 1,
                              onPressed: () {
                                cubit.sendMessage(
                                    text: _messageController.text,
                                    receiverId: '${userModel.uId}',
                                    dateTime: DateTime.now().toString());
                                _messageController.text = '';
                              },
                              child: Icon(
                                IconBroken.Send,
                                size: SizeConfig.scaleHeight(20),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget message(MessageModel model) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.scaleHeight(5),
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(10),
              vertical: SizeConfig.scaleHeight(5),
            ),
            child: Text(
              '${model.text}',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(14),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15),
                topStart: Radius.circular(15),
                bottomEnd: Radius.circular(15),
              ),
            ),
          ),
        ),
      );

  Widget myMessage(MessageModel model) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.scaleHeight(5),
        ),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(10),
              vertical: SizeConfig.scaleHeight(5),
            ),
            child: Text(
              '${model.text}',
              style: TextStyle(
                // color: Colors.white,
                fontSize: SizeConfig.scaleTextFont(14),
              ),
            ),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(.4),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15),
                topStart: Radius.circular(15),
                bottomStart: Radius.circular(15),
              ),
            ),
          ),
        ),
      );
}
