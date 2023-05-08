import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class KeyChainRepo extends GetxService {
  final ApiClient apiClient;
  KeyChainRepo({required this.apiClient});
  Future<Response> getKeyChainList() async {
   
   return await apiClient.getData(AppConstants.KEYCHAIN_PRODUCT_URI);
   
  }
}
