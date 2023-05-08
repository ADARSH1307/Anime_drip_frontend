import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/models/product.dart';

class Shoes extends GetxController{
  final ShoesRepo shoeRepo;
   Shoes( {required this.shoeRepo});

   List<dynamic> _shoeList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get shoeList => _shoeList;
 
  int get length =>_shoeList.length;

  get img => null;

  Future<void> getShoesList() async {
     

      Response response = await shoeRepo.getShoesList();
      if (response.statusCode == 200) {
  
        _shoeList = [];
        _shoeList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }