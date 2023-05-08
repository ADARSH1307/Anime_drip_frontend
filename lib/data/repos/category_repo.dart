import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class CategoryRepo extends GetxService {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});
  Future<Response> getCategoryList() async {
   
   return await apiClient.getData(AppConstants.CATEGORY_PRODUCT_URI);
   
  }
}
