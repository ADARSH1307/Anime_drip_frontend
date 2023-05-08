import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/data/repos/swords_repo.dart';
import 'package:shopping_app/models/product.dart';

class Swords extends GetxController{
  final SwordRepo swordsRepo;
   Swords( {required this.swordsRepo});

   List<dynamic> _swordsList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get swordsList => _swordsList;
 
  int get length =>_swordsList.length;

  get img => null;

  Future<void> getSwordList() async {
     

      Response response = await swordsRepo.getSwordList();
      if (response.statusCode == 200) {
  
        _swordsList = [];
        _swordsList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }