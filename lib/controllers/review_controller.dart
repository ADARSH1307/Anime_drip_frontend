import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/auth_repo.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repos/review_repo.dart';
import 'package:shopping_app/models/response_model.dart';
import 'package:shopping_app/models/review_model.dart';
import 'package:shopping_app/models/signup_body.dart';
import 'package:shopping_app/uitls/app_constants.dart';

class ReviewController extends GetxController implements GetxService {
  final ReviewRepo reviewRepo;

  ReviewController({required this.reviewRepo});

  bool _isLoading = false;
  bool _notification = true;
  bool _acceptTerms = true;

  bool get isLoading => _isLoading;

  bool get notification => _notification;

  bool get acceptTerms => _acceptTerms;
  List<Reviews> _otherList = [];
  List<Reviews> get otherList => _otherList;

  Future<ResponseModel> reviewpost(ReviewModel reviewBody) async {
    _isLoading = true;
    update();
    Response response = await reviewRepo.reviewpost(reviewBody);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      //  reviewRepo.saveUserToken(response.body["token"]);
      //   await reviewRepo.updateToken();

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel =
          ResponseModel(false, response.body["errors"][0]["message"]!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  int get length => _otherList.length;

  get img => null;

  Future<void> getReviewList(bool reload) async {
    if (_otherList == null || reload) {
      Response response = await reviewRepo.getReviewList();
      if (response.statusCode == 200) {
        _otherList = [];
        _otherList.addAll(ReviewModel.fromJson(response.body).products);
        print("adarsgahaja");
        //_popularPageSize = ProductModel.fromJson(response.body).totalSize;

         print("product id is  "+ReviewModel.fromJson(response.body).products.toString());
        _isLoading = true;
        update();
      } else {
        showCustomSnackBar(response.statusText!);
      }
    } else {}
  }

  // Future<ResponseModel> verification(VerificationBody verificationBody) async {
  //   _isLoading = true;
  //   update();
  //  // Response response = await reviewRepo.send_verification(verificationBody);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     print(response.body["data"]);
  //     responseModel = ResponseModel(true, response.body["data"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText!);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> login(String phone, String password) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await reviewRepo.login(phone, password);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {

  //       reviewRepo.saveUserToken(response.body['token']);
  //       await reviewRepo.updateToken();

  //     responseModel = ResponseModel(true,
  //         response.body['token']);
  //   } else {
  //     responseModel = ResponseModel(false, response.body["errors"][0]["message"]!);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  // bool clearSharedData() {
  //   return reviewRepo.clearSharedData();
  // }
  // void saveUserNumberAndPassword(String number, String password) {
  //   reviewRepo.saveUserNumberAndPassword(number, password);
  // }
  // bool isLoggedIn() {
  //   return reviewRepo.isLoggedIn();
  // }
  // String getUserToken() {
  //   return reviewRepo.getUserToken();
  // }
  // Future<void> updateToken() async {
  //   await reviewRepo.updateToken();
  // }
}
