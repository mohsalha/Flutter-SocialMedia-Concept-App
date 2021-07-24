import 'package:flutter/material.dart';
import 'package:social_app/components/consts.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/size_config.dart';

class ChatDetailsScreen extends StatelessWidget {

  final UserModel userModel;


  ChatDetailsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        
        title: Padding(
          padding: EdgeInsetsDirectional.only(top: SizeConfig.scaleHeight(15)),
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
    );
  }
}
