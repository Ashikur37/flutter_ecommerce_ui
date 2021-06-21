import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/address/create_address.dart';
import 'package:commerce/screens/boucher/boucher_screen.dart';
import 'package:commerce/screens/campaign/campaign_product_screen.dart';
import 'package:commerce/screens/campaign/campaign_screen.dart';
import 'package:commerce/screens/categories/categories_screen.dart';
import 'package:commerce/screens/change_password/change_password.dart';
import 'package:commerce/screens/chatscreen/chat_screen.dart';
import 'package:commerce/screens/checkout/checkout_screen.dart';
import 'package:commerce/screens/merchant/merchant_screen.dart';
import 'package:commerce/screens/messagescreen/message_screen.dart';
import 'package:commerce/screens/offer/offer_screen.dart';
import 'package:commerce/screens/order/order_list.dart';
import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/screens/payment/delivery_charge_screen.dart';
import 'package:commerce/screens/payment/payment_screen.dart';
import 'package:commerce/screens/profile/components/basic.dart';
import 'package:commerce/screens/search/search_screen.dart';
import 'package:commerce/screens/shop/shops_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:commerce/screens/sub_category/sub_category_screen.dart';
import 'package:commerce/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:commerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:commerce/screens/home/home_screen.dart';
import 'package:commerce/screens/login_success/login_success_screen.dart';
import 'package:commerce/screens/otp/otp_screen.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
  ShopsScreen.routeName: (context) => ShopsScreen(),
  CampaignScreen.routeName: (context) => CampaignScreen(),
  CampaignProductScreen.routeName: (context) => CampaignProductScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  SubCategoryScreen.routeName: (context) => SubCategoryScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  CreateAddress.routeName: (context) => CreateAddress(),
  AddressList.routeName: (context) => AddressList(),
  BasicProfile.routeName: (context) => BasicProfile(),
  ChangePassword.routeName: (context) => ChangePassword(),
  OrderScreen.routeName: (context) => OrderScreen(),
  OrderList.routeName: (context) => OrderList(),
  StoreScreen.routeName: (context) => StoreScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  BoucherScreen.routeName: (context) => BoucherScreen(),
  OfferScreen.routeName: (context) => OfferScreen(),
  WishListsScreen.routeName: (context) => WishListsScreen(),
  MerchantScreen.routeName: (context) => MerchantScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
  DeliveryChargeScreen.routeName: (context) => DeliveryChargeScreen(),
};
