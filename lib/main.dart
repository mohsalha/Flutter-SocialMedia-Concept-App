import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/screens/add_post_screen/add_post_screen.dart';
import 'package:social_app/screens/edit_profile/edit_profile.dart';
import 'package:social_app/screens/main_screen/main_screen.dart';
import 'package:social_app/screens/launch_screen.dart';
import 'package:social_app/screens/login_screen/login_screen.dart';
import 'package:social_app/screens/register_screen/register_screen.dart';
import 'components/consts.dart';
import 'package:http/http.dart' as http;


main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
print('token is $token');

  FirebaseMessaging.onMessage.listen((event) {
    print('event ${event.data}');
    Fluttertoast.showToast(
        msg: "new notification ${event.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('event ${event.data}');
    Fluttertoast.showToast(
        msg: "new notification ${event.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });


  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return BlocProvider(
      create: (context) => SocialCubit()..getUserData(),
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
