import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shopping_app/controllers/category_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/screens/category/caps.dart';
import 'package:shopping_app/screens/category/hoodie_items_page.dart';
import 'package:shopping_app/screens/category/keychain.dart';
import 'package:shopping_app/screens/category/other.dart';
import 'package:shopping_app/screens/category/pant_items_page.dart';
import 'package:shopping_app/screens/category/shirt.dart';
import 'package:shopping_app/screens/category/shoes.dart';
import 'package:shopping_app/screens/category/special_collection_page.dart';
import 'package:shopping_app/screens/category/sweatshirt.dart';
import 'package:shopping_app/screens/category/swords.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/text_widget.dart';

import '../../components/colors.dart';
import '../../widgets/big_text.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //print("Current height is " + MediaQuery.of(context).size.height.toString());
    return GetBuilder<Category>(
      builder: (categoryProduct) {
        return Container(
          //padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: Scaffold(
            // resizeToAvoidBottomInset: true,

            backgroundColor: AppColors.buttonBackgroundColor,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height45, bottom: Dimensions.height15),
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              BigText(
                                  text: "Anime", color: AppColors.mainColor),
                              Row(
                                children: [
                                  TextWidget(
                                      text: "Drip", color: Colors.black54),
                                  Icon(Icons.arrow_drop_down_rounded)
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: Dimensions.height45,
                            height: Dimensions.height45,
                            child: Icon(Icons.search, color: Colors.white),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              color: AppColors.mainColor,
                            ),
                          )
                        ]),
                  ),
                ),
                
                  //your login class name
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new PantItemsPage())),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL +
                                                  categoryProduct
                                                      .categoryList[0].img)),
                                      color: AppColors.textColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                    height: 250,
                                    width: 180,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                              child: BigText(
                                                  text: categoryProduct
                                                      .categoryList[0].title,
                                                  /* element.value,*/
                                                  color: Colors.black87),
                                            ),
                                            margin: EdgeInsets.only(top: 195),
                                            width: 180,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new HoodieItemsPage())),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.UPLOADS_URL +
                                                        categoryProduct
                                                            .categoryList[1]
                                                            .img)),
                                            color: AppColors.textColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width15),
                                          height: 250,
                                          width: 180,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Center(
                                                    child: BigText(
                                                        text: categoryProduct
                                                            .categoryList[1]
                                                            .title,
                                                        /* element.value,*/
                                                        color: Colors.black87),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(top: 195),
                                                  width: 180,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new ShirtItemsPage())),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL +
                                                  categoryProduct
                                                      .categoryList[2].img)),
                                      color: AppColors.textColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                    height: 250,
                                    width: 180,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                              child: BigText(
                                                  text: categoryProduct
                                                      .categoryList[2].title,
                                                  /* element.value,*/
                                                  color: Colors.black87),
                                            ),
                                            margin: EdgeInsets.only(top: 195),
                                            width: 180,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new SweatshirtItemsPage())),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.UPLOADS_URL +
                                                        categoryProduct
                                                            .categoryList[3]
                                                            .img)),
                                            color: AppColors.textColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width15),
                                          height: 250,
                                          width: 180,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Center(
                                                    child: BigText(
                                                        text: categoryProduct
                                                            .categoryList[3]
                                                            .title,
                                                        /* element.value,*/
                                                        color: Colors.black87),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(top: 195),
                                                  width: 180,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new SwordsItemsPage())),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL +
                                                  categoryProduct
                                                      .categoryList[4].img)),
                                      color: AppColors.textColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                    height: 250,
                                    width: 180,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                              child: BigText(
                                                  text: categoryProduct
                                                      .categoryList[4].title,
                                                  /* element.value,*/
                                                  color: Colors.black87),
                                            ),
                                            margin: EdgeInsets.only(top: 195),
                                            width: 180,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new CapsItemsPage())),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.UPLOADS_URL +
                                                        categoryProduct
                                                            .categoryList[5]
                                                            .img)),
                                            color: AppColors.textColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width15),
                                          height: 250,
                                          width: 180,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Center(
                                                    child: BigText(
                                                        text: categoryProduct
                                                            .categoryList[5]
                                                            .title,
                                                        /* element.value,*/
                                                        color: Colors.black87),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(top: 195),
                                                  width: 180,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new KeychainItemsPage())),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL +
                                                  categoryProduct
                                                      .categoryList[6].img)),
                                      color: AppColors.textColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                    height: 250,
                                    width: 180,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                              child: BigText(
                                                  text: categoryProduct
                                                      .categoryList[6].title,
                                                  /* element.value,*/
                                                  color: Colors.black87),
                                            ),
                                            margin: EdgeInsets.only(top: 195),
                                            width: 180,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new ShoesItemsPage())),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.UPLOADS_URL +
                                                        categoryProduct
                                                            .categoryList[7]
                                                            .img)),
                                            color: AppColors.textColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width15),
                                          height: 250,
                                          width: 180,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Center(
                                                    child: BigText(
                                                        text: categoryProduct
                                                            .categoryList[7]
                                                            .title,
                                                        /* element.value,*/
                                                        color: Colors.black87),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(top: 195),
                                                  width: 180,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /* Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL +
                                                  categoryProduct
                                                      .categoryList[8].img)),
                                      color: AppColors.textColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        bottom: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width15),
                                    height: 250,
                                    width: 180,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                              child: BigText(
                                                  text: categoryProduct
                                                      .categoryList[8].title,
                                                  /* element.value,*/
                                                  color: Colors.black87),
                                            ),
                                            margin: EdgeInsets.only(top: 195),
                                            width: 180,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.UPLOADS_URL +
                                                        categoryProduct
                                                            .categoryList[9]
                                                            .img)),
                                            color: AppColors.textColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                              left: Dimensions.width10,
                                              right: Dimensions.width15),
                                          height: 250,
                                          width: 180,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  child: Center(
                                                    child: BigText(
                                                        text: categoryProduct
                                                            .categoryList[9]
                                                            .title,
                                                        /* element.value,*/
                                                        color: Colors.black87),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(top: 195),
                                                  width: 180,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),*/
                    ],
                  ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
