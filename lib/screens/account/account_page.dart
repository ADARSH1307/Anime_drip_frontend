import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/base/go_to_sign_in_page.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/account/update_account_page.dart';
import 'package:shopping_app/screens/support/support_page.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/account_widgets.dart';
import 'package:get/get.dart';

import '../../base/custom_image.dart';
import '../../controllers/splash_controller.dart';
import '../home/update_dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  _loadUserInfo() async {
    await Get.find<LocationController>().getAddressList();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      var address = Get.find<LocationController>().addressList[0];
      await Get.find<LocationController>().saveUserAddress(address);
    } else {
      print("addresslist is empty");
    }
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

  @override
  Widget build(BuildContext context) {
    
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<LocationController>().addressList.isEmpty) {
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
      _loadUserInfo();
      print(".........");
    } else {
      print("empty" + _isLoggedIn.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr),
        backgroundColor: AppColors.mainColor,
      ),
      // backgroundColor: Colors.white10,
      body: Container(
        color: Colors.white10,
        margin: Dimensions.isWeb
            ? EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                right: Dimensions.MARGIN_SIZE_EXTRA_LARGE)
            : EdgeInsets.all(0),
        child: GetBuilder<UserController>(builder: (userController) {
          var path =
              '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}'
              '/${(Get.find<UserController>().userInfoModel != null && Get.find<AuthController>().isLoggedIn()) ? Get.find<UserController>().userInfoModel?.image : ''}';
          //  print("my image is "+'${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}');
          return (_isLoggedIn)
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: Dimensions.width10 * 15,
                      height: Dimensions.width10 * 15,
                      child: ClipOval(
                          child:
                              Get.find<UserController>().userInfoModel?.image ==
                                      null
                                  ? Image.asset(
                                      "assets/image/logo.png",
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.network(
                                      path,
                                      fit: BoxFit.fill,
                                    )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.transparent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              AccountWidgets(
                                  userController.userInfoModel!.fName,
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              AccountWidgets(
                                  userController.userInfoModel!.phone,
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.yellowColor),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              AccountWidgets(
                                  userController.userInfoModel!.email,
                                  icon: Icons.email,
                                  backgroundColor: AppColors.yellowColor),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              // GetBuilder<LocationController>(
                              //     builder: (locationController) {
                              //   if (_isLoggedIn &&
                              //       Get.find<LocationController>()
                              //           .addressList
                              //           .isEmpty) {
                              //     return GestureDetector(
                              //       onTap: () {
                              //         Get.toNamed(
                              //             RouteHelper.getAddAddressRoute());
                              //       },
                              //       child: AccountWidgets(
                              //           "fill_in_your_address".tr,
                              //           icon: Icons.location_on,
                              //           backgroundColor:
                              //               AppColors.yellowColor),
                              //     );
                              //   } else {
                              //     return GestureDetector(
                              //       onTap: () {
                              //         Get.toNamed(
                              //             RouteHelper.getAddAddressRoute());
                              //       },
                              //       child: AccountWidgets("address".tr,
                              //           icon: Icons.location_on,
                              //           backgroundColor:
                              //               AppColors.yellowColor),
                              //     );
                              //   }
                              // }),
                              // SizedBox(
                              //   height: Dimensions.height10,
                              // ),
                              // // AccountWidgets("no_message".tr,
                              // //     icon: Icons.message,
                              // //     backgroundColor: Colors.redAccent),
                              // // SizedBox(
                              // //   height: Dimensions.height10,
                              // // ),
                              GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateAccountPage(),
                                        ),
                                      ),
                                  child: AccountWidgets("edit_profile".tr,
                                      icon: Icons.edit,
                                      backgroundColor: Colors.redAccent)),

                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SupportPage(),
                                  ),
                                ),
                                child: AccountWidgets("Help and Support",
                                    icon: Icons.message,
                                    backgroundColor: Colors.redAccent),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .isLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>()
                                          .clearCartList();
                                      Get.find<LocationController>()
                                          .clearAddressList();
                                      Get.offAllNamed(
                                          RouteHelper.getInitialRoute());
                                    }
                                  },
                                  child: AccountWidgets("logout".tr,
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : GoToSignInPage();
        }),
      ),
    );
  }
}
