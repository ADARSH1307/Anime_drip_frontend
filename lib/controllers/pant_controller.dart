import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/models/product.dart';

class Pant extends GetxController{
  final PantRepo pantRepo;
   Pant( {required this.pantRepo});

   List<dynamic> _pantList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get pantList => _pantList;
 
  int get length =>_pantList.length;

  get img => null;

  Future<void> getPantList() async {
     

      Response response = await pantRepo.getPantList();
      if (response.statusCode == 200) {
  
        _pantList = [];
        _pantList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }