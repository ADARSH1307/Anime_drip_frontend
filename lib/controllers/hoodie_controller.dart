import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/models/product.dart';

class Hoodie extends GetxController{
  final HoodieRepo hoodieRepo;
   Hoodie( {required this.hoodieRepo});

   List<dynamic> _hoodieList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get hoodieList => _hoodieList;
 
  int get length =>_hoodieList.length;

  get img => null;

  Future<void> getHoodieList() async {
     

      Response response = await hoodieRepo.getHoodieList();
      if (response.statusCode == 200) {
  
        _hoodieList = [];
        _hoodieList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }