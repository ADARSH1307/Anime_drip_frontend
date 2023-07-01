import 'package:get/get_utils/src/platform/platform.dart';
import '../models/language_model.dart';
import 'images.dart';
import 'package:get/get.dart';
class AppConstants {
  static const String APP_NAME = 'DBFood';
  static const int APP_VERSION = 1;
  //https://youtu.be/HCUZ91NVnaM learn here how to set up google map api key
  static const String MAP_API_KEY = "Your key";
  static const String STORE_PREFERENCE = 'Cart-list';
  static bool IS_IOS = GetPlatform.isIOS;
  //your base url
  //https://youtu.be/DjXS9W1HD9U here how to set up the admin panel
 static const String BASE_URL = 'https://animedrip.saw-erp.in';
   //static const String BASE_URL = 'http://192.168.48.66:5050';

  // static const String BASE_URL = 'http://10.0.2.2:8000';
  static const String REGISTER_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static String UPLOADS_URL = BASE_URL + '/uploads/';
  static const String SEARCH_URI = '/api/v1/products/search';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String UPDATE_ACCOUNT_URI = '/api/v1/customer/update-profile';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String REMOVE_ADDRESS_URI =
      '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';

  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String TOKEN = 'dbshop_token';
  static const String RECOMMENDED_PRODUCT_URI = '/api/v1/products/recommended';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/products/category';
  static const String PANTS_PRODUCT_URI = '/api/v1/products/pant';
  static const String HOODIES_PRODUCT_URI = '/api/v1/products/hoodie';
  static const String SHIRTS_PRODUCT_URI = '/api/v1/products/shirts';
  static const String SWEATSHIRT_PRODUCT_URI = '/api/v1/products/sweatshirts';
  static const String CAPS_PRODUCT_URI = '/api/v1/products/caps';
  static const String SWORDS_PRODUCT_URI = '/api/v1/products/swords';
  static const String KEYCHAIN_PRODUCT_URI = '/api/v1/products/keychain';
  static const String SHOES_PRODUCT_URI = '/api/v1/products/shoes';
  static const String OTHERS_PRODUCT_URI = '/api/v1/products/others';
  static const String REVIEWS_PRODUCT_URI = '/api/v1/products/reviews';
  static const String FAILED_LOGIN_URI = '/api/v1/products/failed_login';

  static const String RECOMMENDED_PRODUCT_URI_TEST = '/api/v1/products/test';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI =
      '/api/v1/customer/order/details?order_id=';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String SEARCH_LOCATION_URI =
      '/api/v1/config/place-api-autocomplete';
  static const String CONFIG_URI = '/api/v1/config';
  static const String SEND_VERIFY = '/api/v1/send_verification';
  static const String CART_LIST = 'cart_list';

  /*
  Localization data
   */
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String INTRO = 'introduction';

  /*
  Notification
   */
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String NOTIFICATION = 'notification';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    //   LanguageModel(
    //       imageUrl: Images.bengali,
    //       languageName: 'বাংলা',
    //       countryCode: 'BD',
    //       languageCode: 'bn'),
  ];
}
