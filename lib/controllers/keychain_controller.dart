import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/data/repos/hoodie_repo.dart';
import 'package:shopping_app/data/repos/keychain_repo.dart';
import 'package:shopping_app/data/repos/pant_repo.dart';
import 'package:shopping_app/data/repos/shoes_repo.dart';
import 'package:shopping_app/models/product.dart';

class Keychain extends GetxController{
  final KeyChainRepo keychainRepo;
   Keychain( {required this.keychainRepo});

   List<dynamic> _keychainList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get keychainList => _keychainList;
 
  int get length =>_keychainList.length;

  get img => null;

  Future<void> getKeyChainList() async {
     

      Response response = await keychainRepo.getKeyChainList();
      if (response.statusCode == 200) {
  
        _keychainList = [];
        _keychainList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }