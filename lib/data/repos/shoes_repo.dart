import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class ShoesRepo extends GetxService {
  final ApiClient apiClient;
  ShoesRepo({required this.apiClient});
  Future<Response> getShoesList() async {
   
   return await apiClient.getData(AppConstants.SHOES_PRODUCT_URI);
   
  }
}
