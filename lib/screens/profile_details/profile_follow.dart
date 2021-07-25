import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/controller/app_controller.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/size_config.dart';

class ProfileFollow extends StatelessWidget {
  final UserModel userModel;

  ProfileFollow(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.scaleHeight(175),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: SizeConfig.scaleHeight(140),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${userModel.cover}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 42,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${userModel.image}',
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 40,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${userModel.name}',
            style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(18),
              letterSpacing: SizeConfig.scaleWidth(1.1),
              color: Colors.black,
            ),
          ),
          Text(
            '${userModel.bio}',
            style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(14),
              color: Colors.grey[700],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(20)),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: SizeConfig.scaleHeight(40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: defaultColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Follow',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.scaleHeight(20),
          ),
        ],
      ),
    );
  }
}
