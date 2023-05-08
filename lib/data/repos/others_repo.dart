import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class OtherRepo extends GetxService {
  final ApiClient apiClient;
  OtherRepo({required this.apiClient});
  Future<Response> getOthersList() async {
   
   return await apiClient.getData(AppConstants.OTHERS_PRODUCT_URI);
   
  }
}
