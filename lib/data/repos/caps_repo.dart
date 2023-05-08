import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:get/get.dart';

class CapRepo extends GetxService {
  final ApiClient apiClient;
  CapRepo({required this.apiClient});
  Future<Response> getCapList() async {
    return await apiClient.getData(AppConstants.CAPS_PRODUCT_URI);
  }
}
