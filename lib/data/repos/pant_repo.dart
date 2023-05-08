import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class PantRepo extends GetxService {
  final ApiClient apiClient;
  PantRepo({required this.apiClient});
  Future<Response> getPantList() async {
   
   return await apiClient.getData(AppConstants.PANTS_PRODUCT_URI);
   
  }
}
