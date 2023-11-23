import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shopping_app/base/go_to_sign_in_page.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'package:shopping_app/screens/home/update_dialog.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/uitls/styles.dart';

import 'order_view.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
 late TabController _tabController;
 late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
final newVersion = NewVersionPlus(
      androidId: 'org.telegram.messenger',
    );

    Timer(const Duration(milliseconds: 800), () {
      checkNewVersion(newVersion);
    });
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders and Review".tr),
        backgroundColor: AppColors.mainColor,
      ),
      body: _isLoggedIn ? GetBuilder<OrderController>(
        builder: (orderController) {
          return Column(children: [

            Center(
              child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.fontSizeSmall),
                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).primaryColor),
                  tabs: [
                    Tab(text: 'running'.tr),
                    Tab(text: 'history'.tr),
                  ],
                ),
              ),
            ),

            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                OrderView(isRunning: true),
                OrderView(isRunning: false),
              ],
            )),

          ]);
        },
      ) : GoToSignInPage(),
    );
  }
}