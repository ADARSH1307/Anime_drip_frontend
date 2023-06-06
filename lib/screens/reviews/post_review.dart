import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';
import '../../base/confirm_dialogue.dart';
import '../../base/custom_button.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/splash_controller.dart';
import '../../helper/app_date_converter.dart';
import '../../models/order_detail_model.dart';
import '../../models/order_model.dart';
import '../../routes/route_helper.dart';
import '../../uitls/app_dimensions.dart';
import '../../uitls/images.dart';
import '../../uitls/styles.dart';
import 'package:get/get.dart';

class PostReviewPage extends StatefulWidget {
  final OrderModel? orderModel;

  final int orderId;
  PostReviewPage({required this.orderModel, required this.orderId});

  @override
  _PostReviewPageState createState() => _PostReviewPageState();
}

class _PostReviewPageState extends State<PostReviewPage> {
  late StreamSubscription _stream;

  void _loadData(BuildContext context, bool reload) async {
    await Get.find<OrderController>().trackOrder(
        widget.orderId.toString(), reload ? null : widget.orderModel, false);
    if (widget.orderModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    print("my order id is " + widget.orderId.toString());
    Get.find<OrderController>().getOrderDetails(widget.orderId.toString());
  }

  @override
  void initState() {
    super.initState();

    _stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage on Details: ${message.data}");
      _loadData(context, true);
    });

    _loadData(context, false);
  }

  @override
  void dispose() {
    super.dispose();

    _stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var productReviewController = TextEditingController();
     void _register() async {
      String _name = nameController.text.trim();
      String _productReview = productReviewController.text.trim();

      if (_name.isEmpty) {
        showCustomSnackBar('Enter your name'.tr);
        return;
      } else if (_productReview.isEmpty) {
        showCustomSnackBar('Enter product review'.tr);
        return;
      }
      ;
    }
    return WillPopScope(
      onWillPop: () async {
        if (widget.orderModel == null) {
          // return Get.offAllNamed(RouteHelper.getInitial());
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: /*CustomAppBar(title: 'order_details'.tr, onBackPressed: () {
          if(widget.orderModel == null) {
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }else {
            Get.back();
          }
        }),*/
            AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Post a Review".tr),
        ),
        body: GetBuilder<OrderController>(builder: (orderController) {
          double _deliveryCharge = 0;
          double _itemsPrice = 0;
          double _discount = 0;
          double _couponDiscount = 0;
          double _tax = 0;
          double _addOns = 0;
          
          OrderModel? _order = orderController.trackModel;

          double _subTotal = _itemsPrice + _addOns;
          for (OrderDetailsModel orderDetails in orderController.orderDetails) {
            _itemsPrice =
                _itemsPrice + (orderDetails.price * orderDetails.quantity);
        
          }
          
          double _total = _itemsPrice +
              _addOns -
              _discount +
              _tax +
              _deliveryCharge -
              _couponDiscount;

          return orderController.orderDetails.isNotEmpty
              ? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              // BigText(text: "   Enter Name", color: AppColors.mainBlackColor),

              AppTextField(
                hintText: "name".tr,
                textController: nameController,
                icon: Icons.person,
              ),
              SizedBox(
                height: 50,
              ),
              AppTextField(
                maxLines: true,
                hintText: "Write your feedback here....".tr,
                textController: productReviewController,
                icon: Icons.description,
              ),
              SizedBox(
                height: 70,
              ),
              Text(_order!.id.toString(),
                                          style: robotoMedium),
              GestureDetector(
                onTap: () {
                  _register();
                },
                child: Center(
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor),
                    child: Center(
                      child: BigText(
                        text: 'Submit'.tr,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
