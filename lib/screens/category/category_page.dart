import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/controllers/category_controller.dart';
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
import 'package:shopping_app/screens/home/update_dialog.dart';
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
  void initState() {
    super.initState();
     final newVersion = NewVersionPlus(
      androidId: 'org.telegram.messenger',
    );

    Timer(const Duration(milliseconds: 800), () {
      checkNewVersion(newVersion);
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
  Widget build(BuildContext context) {
    return GetBuilder<Category>(
      builder: (categoryProduct) {
        return Scaffold(
          backgroundColor: AppColors.buttonBackgroundColor,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height45,
                  bottom: Dimensions.height15,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Anime",
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            TextWidget(
                              text: "Drip",
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ],
                    ),
                    // Container(
                    //   width: Dimensions.height45,
                    //   height: Dimensions.height45,
                    //   child: Icon(Icons.search, color: Colors.white),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(
                    //       Dimensions.radius15,
                    //     ),
                    //     color: AppColors.mainColor,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PantItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[0].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[0].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HoodieItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[1].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[1].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ShirtItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[2].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.02,
                            horizontal: Dimensions.width10,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[2].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SweatshirtItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[3].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[3].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SwordsItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[4].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[4].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => CapsItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[5].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[5].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                KeychainItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[6].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[6].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ShoesItemsPage(),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.UPLOADS_URL +
                                    categoryProduct.categoryList[7].img,
                              ),
                            ),
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height10,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius15,
                                ),
                              ),
                              child: Center(
                                child: BigText(
                                  text: categoryProduct.categoryList[7].title,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
