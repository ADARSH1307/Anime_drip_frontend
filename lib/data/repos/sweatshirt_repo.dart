import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class SweatShirtRepo extends GetxService {
  final ApiClient apiClient;
  SweatShirtRepo({required this.apiClient});
  Future<Response> getSweatShirtList() async {
   
   return await apiClient.getData(AppConstants.SWEATSHIRT_PRODUCT_URI);
   
  }
}
