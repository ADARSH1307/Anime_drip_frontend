import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class SwordRepo extends GetxService {
  final ApiClient apiClient;
  SwordRepo({required this.apiClient});
  Future<Response> getSwordList() async {
   
   return await apiClient.getData(AppConstants.SWORDS_PRODUCT_URI);
   
  }
}
