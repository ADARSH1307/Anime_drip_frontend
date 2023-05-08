import 'package:get/get.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/data/repos/category_repo.dart';
import 'package:shopping_app/models/product.dart';

class Category extends GetxController{
  final CategoryRepo categoryRepo;
   Category( {required this.categoryRepo});

   List<dynamic> _categoryList=[];
  
  //works with the add or remove button. after adding or removing it's set to zero again
  

  

  List<dynamic> get categoryList => _categoryList;
 
  int get length =>_categoryList.length;

  get img => null;

  Future<void> getCategoryList() async {
     

      Response response = await categoryRepo.getCategoryList();
      if (response.statusCode == 200) {
  print("asdfgh");
        _categoryList = [];
        _categoryList.addAll(ProductModel.fromJson(response.body).products);
     
        update();
      }else{
        showCustomSnackBar(response.statusText!);
      }
     

    
  }
  }