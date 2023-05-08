import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/caps_repo.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/models/product.dart';

class Caps extends GetxController{
  final CapRepo capsRepo;
   Caps( {required this.capsRepo});

   List<dynamic> _capsList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get capsList => _capsList;
 
  int get length =>_capsList.length;

  get img => null;

  Future<void> getCapList() async {
     

      Response response = await capsRepo.getCapList();
      if (response.statusCode == 200) {
  
        _capsList = [];
        _capsList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }