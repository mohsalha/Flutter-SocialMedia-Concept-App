import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controller/app_controller.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/screens/add_post_screen/add_post_screen.dart';
import 'package:social_app/screens/edit_profile/edit_profile.dart';
import 'package:social_app/screens/main_screen/main_screen.dart';
import 'package:social_app/screens/launch_screen.dart';
import 'package:social_app/screens/login_screen/login_screen.dart';
import 'package:social_app/screens/register_screen/register_screen.dart';
import 'package:social_app/size_config.dart';

import 'components/consts.dart';

main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => SocialCubit()
          ..getUserData()
          ..getPost(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'jannah',
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor: greyColor,
              elevation: 20,
              backgroundColor: Colors.white,
            ),
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleSpacing: 20,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
                size: 15,
              ),
              centerTitle: false,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => LaunchScreen(),
            '/login_screen': (context) => LoginScreen(),
            '/register_screen': (context) => RegisterScreen(),
            '/main_screen': (context) => MainScreen(),
            '/add_post_screen': (context) => AddPostScreen(),
            '/edit_screen': (context) => EditProfile(),
          },
        ),
      );

  }
}
