import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class HoodieRepo extends GetxService {
  final ApiClient apiClient;
  HoodieRepo({required this.apiClient});
  Future<Response> getHoodieList() async {
   
   return await apiClient.getData(AppConstants.HOODIES_PRODUCT_URI);
   
  }
}
