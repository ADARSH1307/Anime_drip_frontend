import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/caps_repo.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/data/repos/sweatshirt_repo.dart';
import 'package:shopping_app/models/product.dart';

class Sweatshirt extends GetxController{
  final SweatShirtRepo sweatshirtrepo;
   Sweatshirt( {required this.sweatshirtrepo});

   List<dynamic> _sweatshirtList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get sweatshirtList => _sweatshirtList;
 
  int get length =>_sweatshirtList.length;

  get img => null;

  Future<void> getSweatShirtList() async {
     

      Response response = await sweatshirtrepo.getSweatShirtList();
      if (response.statusCode == 200) {
  _sweatshirtList = [];
        _sweatshirtList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }