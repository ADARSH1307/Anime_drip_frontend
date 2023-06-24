import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/caps_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/category_controller.dart';
import 'package:shopping_app/controllers/hoodie_controller.dart';
import 'package:shopping_app/controllers/keychain_controller.dart';
import 'package:shopping_app/controllers/localization_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/notification_controller.dart';
import 'package:shopping_app/controllers/other_controller.dart';
import 'package:shopping_app/controllers/pant_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/review_controller.dart';
import 'package:shopping_app/controllers/search_product_controller.dart';
import 'package:shopping_app/controllers/shirt_controller.dart';
import 'package:shopping_app/controllers/shoes_controller.dart';
import 'package:shopping_app/controllers/sweatshirt_controller.dart';
import 'package:shopping_app/controllers/swords_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/data/repos/auth_repo.dart';
import 'package:shopping_app/data/repos/caps_repo.dart';
import 'package:shopping_app/data/repos/cart_repo.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/keychain_repo.dart';
import 'package:shopping_app/data/repos/location_repo.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/data/repos/order_repo.dart';
import 'package:shopping_app/data/repos/others_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/popular_product_repo.dart';
import 'package:shopping_app/data/repos/product_repo.dart';
import 'package:shopping_app/data/repos/review_repo.dart';
import 'package:shopping_app/data/repos/search_product_repo.dart';
import 'package:shopping_app/data/repos/shirts_repo.dart';
import 'package:shopping_app/data/repos/sweatshirt_repo.dart';
import 'package:shopping_app/data/repos/swords_repo.dart';
import 'package:shopping_app/data/repos/user_repo.dart';
import 'package:shopping_app/uitls/app_constants.dart';

import '../controllers/splash_controller.dart';
import '../data/repos/notification_repo.dart';
import '../data/repos/shoes_repo.dart';
import '../data/repos/splash_repo.dart';
import '../models/language_model.dart';

Future<Map<String, Map<String, String>>> init() async {

  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  //first load the repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
   Get.lazyPut(() => ReviewRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
        Get.lazyPut(() => PantRepo(apiClient: Get.find()));
                Get.lazyPut(() => HoodieRepo(apiClient: Get.find()));
 Get.lazyPut(() => ShirtRepo(apiClient: Get.find()));
  Get.lazyPut(() => SweatShirtRepo(apiClient: Get.find()));
   Get.lazyPut(() => SwordRepo(apiClient: Get.find()));
    Get.lazyPut(() => CapRepo(apiClient: Get.find()));
     Get.lazyPut(() => KeyChainRepo(apiClient: Get.find()));
  Get.lazyPut(() => ShoesRepo(apiClient: Get.find()));
   Get.lazyPut(() => OtherRepo(apiClient: Get.find()));


  Get.lazyPut(() => SearchProductRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
   Get.lazyPut(() => ReviewController(reviewRepo: Get.find()));

  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => PopularProduct(popularProductRepo: Get.find()));
    Get.lazyPut(() => Category(categoryRepo: Get.find()));
        Get.lazyPut(() => Pant(pantRepo: Get.find()));
 Get.lazyPut(() => Shirt(shirtrepo: Get.find()));
 Get.lazyPut(() => Sweatshirt(sweatshirtrepo: Get.find()));
 Get.lazyPut(() => Swords(swordsRepo: Get.find()));
 Get.lazyPut(() => Caps(capsRepo: Get.find()));
 Get.lazyPut(() => Keychain(keychainRepo: Get.find()));
 Get.lazyPut(() => Shoes(shoeRepo: Get.find()));
 Get.lazyPut(() => Other(otherRepo: Get.find()));
  Get.lazyPut(() => Hoodie(hoodieRepo: Get.find()));


       


  Get.lazyPut(() => CartController(cartRepo:Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => SearchProductController(searchProductRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();

    _mappedJson.forEach((key, value) {

      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }

  return _languages;
}