import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/models/user_model.dart';

class AppController{

  AppController._(){
    init();
  }

  static AppController _instance = AppController._();

  static AppController get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future init() async{

    _sharedPreferences = await SharedPreferences.getInstance();

  }

  Future savaUser(UserModel user)async{
    await _sharedPreferences.setBool('loggedIn', true);
    await _sharedPreferences.setString('name', user.name ?? '');
    await _sharedPreferences.setString('email', user.email ?? '');
    await _sharedPreferences.setString('uId', user.uId ?? '');
    await _sharedPreferences.setString('phone', user.phone ?? '');
    await _sharedPreferences.setString('cover', user.cover ?? '');
    await _sharedPreferences.setString('bio', user.bio ?? '');
    await _sharedPreferences.setString('image', user.image ?? '');
  }
  Future isLoggedIn(bool loggedIn)async{
    await _sharedPreferences.setBool('loggedIn', loggedIn);
  }

  Future setUId(String uId)async{
    await _sharedPreferences.setString('uId', uId);
  }
  bool loggedIn(){
    return  _sharedPreferences.getBool('loggedIn') ?? false;
  }

  String getName(){
    return  _sharedPreferences.getString('name') ?? '';
  }
  String getEmail(){
    return  _sharedPreferences.getString('email') ?? '';
  }
  String getUId(){
    return  _sharedPreferences.getString('uId') ?? '';
  }
  String getImage(){
    return  _sharedPreferences.getString('image') ?? '';
  }
  String getPhone(){
    return  _sharedPreferences.getString('phone') ?? '';
  }

  Future logout()async{
    await _sharedPreferences.clear();
  }


}