import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/others_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/models/product.dart';

class Other extends GetxController{
  final OtherRepo otherRepo;
   Other( {required this.otherRepo});

   List<dynamic> _otherList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get otherList => _otherList;
 
  int get length =>_otherList.length;

  get img => null;

  Future<void> getOthersList() async {
     

      Response response = await otherRepo.getOthersList();
      if (response.statusCode == 200) {
  
        _otherList = [];
        _otherList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }