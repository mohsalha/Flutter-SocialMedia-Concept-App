import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/controller/app_controller.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/size_config.dart';

class SettingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = SocialCubit.get(context).user;
        if(cubit != null){
          return Column(
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
                            image: NetworkImage('${cubit.cover}'),
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
                          '${cubit.image}',
                        ),
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${cubit.name}',
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(18),
                  letterSpacing: SizeConfig.scaleWidth(1.1),
                  color: Colors.black,
                ),
              ),
              Text(
                '${cubit.bio}',
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
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: SizeConfig.scaleHeight(40),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit_screen');
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: SizeConfig.scaleTextFont(18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {
                      Navigator.pushNamed(context, '/edit_screen');

                    }, icon: Icon(IconBroken.Edit))
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(20),),
              SizedBox(
                height: SizeConfig.scaleHeight(40),
                child: OutlinedButton(
                  onPressed: () {
                    SocialCubit.get(context).logout();
                    AppController.instance.logout();
                    cubit = null;
                    SocialCubit.get(context).currentIndex = 0;
                    Navigator.pushNamed(context, '/login_screen');
                  },
                  child: Text(
                    'logout',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(18),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }
}
