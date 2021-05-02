import 'package:commerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:commerce/screens/forget_password/forget_password_screen.dart';
import 'package:commerce/screens/home/home_screen.dart';
import 'package:commerce/screens/login_success/login_success_screen.dart';
import 'package:commerce/screens/sign_up/signup_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/screens/splash/splash_screen.dart';

final routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
