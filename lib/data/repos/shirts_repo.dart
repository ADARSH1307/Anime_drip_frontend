import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class ShirtRepo extends GetxService {
  final ApiClient apiClient;
  ShirtRepo({required this.apiClient});
  Future<Response> getShirtList() async {
   
   return await apiClient.getData(AppConstants.SHIRTS_PRODUCT_URI);
   
  }
}
