import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/caps_repo.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shirts_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/data/repos/sweatshirt_repo.dart';
import 'package:shopping_app/models/product.dart';

class Shirt extends GetxController{
  final ShirtRepo shirtrepo;
   Shirt( {required this.shirtrepo,});

   List<dynamic> _shirtList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get shirtList => _shirtList;
 
  int get length =>_shirtList.length;

  get img => null;

  Future<void> getShirtList() async {
     

      Response response = await shirtrepo.getShirtList();
      if (response.statusCode == 200) {
  _shirtList = [];
        _shirtList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }