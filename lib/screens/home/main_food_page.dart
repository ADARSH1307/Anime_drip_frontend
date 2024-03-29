import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/category_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/home/update_dialog.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/icon_text_widget.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class MainFoodPage extends StatefulWidget {
  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  ProductController controller = Get.find();
  PopularProduct popularProductController = Get.find();
  //Category controllers = Get.find();
  PageController pageController =
      PageController(viewportFraction: Dimensions.viewPort);
  var _currPageValue = 0.0;
  @override
  void initState() {
    super.initState();
        final newVersion = NewVersionPlus(
      androidId: 'org.telegram.messenger',
    );

    Timer(const Duration(milliseconds: 800), () {
      checkNewVersion(newVersion);
    });
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }
 void checkNewVersion(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if(status != null) {
      if(status.canUpdate) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(
              allowDismissal: false,
              description: "• Separated tabs for chats: users, groups, channels, bots, favorites, unread, admin/creator. • Many options to cutomize tabs. • Multi-account (upto 10). • Categories. Create custom groups of chats (family, work, sports...). • Categories can be saved and restored. • Change default app folder.",
              version: status.storeVersion,
              appLink: status.appStoreLink,
            );
          },
        );
        // newVersion.showUpdateDialog(
        //   context: context,
        //   versionStatus: status,
        //   dialogText: 'New Version is available in the store (${status.storeVersion}), update now!',
        //   dialogTitle: 'Update is Available!',
        // );
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  final places = {
    // "img/anime_drip logo.png":"Cumin Barbecue",
    // "img/anime_drip logo.png":"Chinese Side",
    //"img/anime_drip logo.png":"Breakfast Savor",
    //"img/anime_drip logo.png":"Breakfast1 Savor",
    //"img/anime_drip logo.png":"Breakfast2 Savor",
  };

  //scale factor
  double _scaleFactor = .8;
  //view page height
  double _height = Dimensions.pageViewCon;
  _buildPageItem(int index, Product product) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(
                RouteHelper.getRecommendedFoodRoute(index, "recommended"));
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                /*Container(
                    padding:  EdgeInsets.only(left: Dimensions.padding20, top: Dimensions.padding20),
                    //previously 220
                    height: Dimensions.pageViewInnerCon,
                    width: MediaQuery.of(context).size.width-20,
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.padding30),
                        color:index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                AppConstants.UPLOADS_URL+product.img
                            )
                        )
                    ),

                  ),*/
                CachedNetworkImage(
                  imageUrl: AppConstants.UPLOADS_URL + product.img,
                  imageBuilder: (context, imageProvider) => Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.padding20, top: Dimensions.padding20),
                    height: Dimensions.pageViewInnerCon,
                    width: MediaQuery.of(context).size.width - 20,
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.padding30),
                      color:
                          index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                      image: DecorationImage(
                        //image size fill
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child:
                        CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                  ), //show progress  while loading image
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/image/icon.png"),
                  //show no image available image on error loading
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: Dimensions.margin40,
                        left: Dimensions.appMargin,
                        right: Dimensions.appMargin),
                    width: double.maxFinite,
                    //previously 120
                    height: Dimensions.pageViewInnerConText,

                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.padding20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFe8e8e8),
                              blurRadius: 5.0,
                              offset: Offset(0, 5)),
                          BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                          BoxShadow(color: Colors.white, offset: Offset(5, 0))
                        ]),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.padding10, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(
                              text: product.title, color: AppColors.titleColor),
                          SizedBox(
                            height: Dimensions.padding10,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    5,
                                    (index) => Icon(Icons.star,
                                        color: AppColors.mainColor, size: 15)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(text: "4.5", color: Color(0xFFccc7c5)),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                  text: "1287 " + "comments".tr,
                                  color: Color(0xFFccc7c5))
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndTextWidget(
                                text: product.price.toString(),
                                color: AppColors.mainBlackColor,
                                icon: Icons.currency_rupee,
                                iconColor: AppColors.mainBlackColor,
                              ),

                              // IconAndTextWidget(text: "1.7km",
                              //   color: AppColors.textColor, icon: Icons.location_on,
                              //   iconColor: AppColors.mainColor,),
                              IconAndTextWidget(
                                  text: "Hot Deals",
                                  color: AppColors.mainBlackColor,
                                  icon: Icons.local_fire_department_sharp,
                                  iconColor: Colors.orange.shade600)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          //for the pageview
          GetBuilder<ProductController>(builder: (productController) {
            return productController.isLoading
                ? Container(
                    color: Color(0xFFf9f9fa),
                    //previously 320
                    height: Dimensions.pageViewCon,

                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: PageView.builder(
                        controller: pageController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: productController.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position,
                              productController.popularProductList[position]);
                        },
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
          //for the dots
          GetBuilder<ProductController>(builder: (productController) {
            return new DotsIndicator(
              dotsCount:
                  productController.length == 0 ? 1 : productController.length,
              position: _currPageValue.toInt(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
          //originally height is 30
          SizedBox(
            height: Dimensions.sizedBoxHeight,
          ),
          //texts and the dot
          Container(
              margin: EdgeInsets.only(left: Dimensions.appMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(text: "Popular".tr, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: BigText(text: ".", color: Colors.black26),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: TextWidget(
                          text: "What most people prefer",
                          color: AppColors.textColor)),
                ],
              )),
          SizedBox(
            height: Dimensions.sizedBoxHeight,
          ),
          //here we do with expanded. but in that case parent is not
          // wraped with singlechild scrollview

          GetBuilder<PopularProduct>(
            builder: (popularProducts) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: Dimensions.padding10),
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getPopularFoodRoute(index, "popular"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.appMargin,
                            right: Dimensions.appMargin,
                            bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*
                                Container(
                                  width: Dimensions.listViewImg,
                                  height: Dimensions.listViewImg,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.padding20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.UPLOADS_URL+popularProducts.popularProductList[index].img

                                          )
                                      )
                                  ),
                                ),*/
                            CachedNetworkImage(
                              imageUrl: AppConstants.UPLOADS_URL +
                                  popularProducts.popularProductList[index].img,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: Dimensions.listViewImg,
                                height: Dimensions.listViewImg,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.padding20),
                                  image: DecorationImage(
                                    //image size fill
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child:
                                    CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                              ), //show progress  while loading image
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/image/icon.png"),
                              //show no image available image on error loading
                            ),
                            Expanded(
                              child: Container(
                                padding: Dimensions.isWeb
                                    ? EdgeInsets.only(
                                        left: Dimensions.PADDING_SIZE_SMALL,
                                        right: Dimensions.PADDING_SIZE_SMALL)
                                    : EdgeInsets.all(0),
                                height: Dimensions.listViewCon,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.padding20),
                                        bottomRight: Radius.circular(
                                            Dimensions.padding20))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.padding10,
                                      right: Dimensions.padding10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: popularProducts
                                              .popularProductList[index].title,
                                          /* element.value,*/
                                          color: Colors.black87),
                                      SizedBox(
                                        height: Dimensions.padding10,
                                      ),
                                      TextWidget(
                                          text: "Bringing Anime to Life",
                                          color: AppColors.textColor),
                                      SizedBox(
                                        height: Dimensions.padding10,
                                      ),
                                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndTextWidget(
                                text:popularProducts
                                              .popularProductList[index].price.toString(),
                                color: AppColors.mainBlackColor,
                                icon: Icons.currency_rupee,
                                iconColor: AppColors.mainBlackColor,
                              ),

                              // IconAndTextWidget(text: "1.7km",
                              //   color: AppColors.textColor, icon: Icons.location_on,
                              //   iconColor: AppColors.mainColor,),
                              IconAndTextWidget(
                                  text: "Hot Deals",
                                  color: AppColors.mainBlackColor,
                                  icon: Icons.local_fire_department_sharp,
                                  iconColor: Colors.orange.shade600)
                            ],
                          ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                },
              );
            },
          )
        ]);
  }
}
