import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/chat_details/chat_details_screen.dart';
import 'package:social_app/screens/profile_details/profile_follow.dart';
import 'package:social_app/size_config.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        if (cubit.users.length > 0) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildChatItem(cubit.users[index], context);
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: SizeConfig.scaleHeight(1),
                  width: double.infinity,
                  color: Colors.grey[300],
                );
              },
              itemCount: cubit.users.length);
        } else if (cubit.users.length == 0) {
          return Center(
            child: Text(
              'sorry not found users, yet',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(18),
                color: Colors.black,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildChatItem(UserModel user, BuildContext context) => Padding(
        padding: EdgeInsets.all(
          SizeConfig.scaleHeight(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                '${user.image}',
              ),
              backgroundColor: defaultColor,
              radius: 30,
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(15),
            ),
            Text(
              '${user.name}',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(14),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatDetailsScreen(user)));
              },
              child: Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(8)),
                child: Icon(
                  IconBroken.Chat,
                  size: SizeConfig.scaleHeight(20),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileFollow(user)));
              },
              child: Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(8)),
                child: Icon(
                  IconBroken.Profile,
                  size: SizeConfig.scaleHeight(20),
                ),
              ),
            ),
          ],
        ),
      );
}
