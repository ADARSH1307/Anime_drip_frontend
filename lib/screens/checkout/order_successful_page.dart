import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/screens/checkout/payment_failed_dialogue.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../base/custom_button.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../uitls/styles.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final String orderID;
  final int status;
  // final Uri phoneNumber=Uri.parse('tel:+91 9353979275');
  // final Uri whatsapp = Uri.parse('https//wa.me/9353979275');
  OrderSuccessfulScreen({required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        Get.dialog(PaymentFailedDialog(orderID: orderID),
            barrierDismissible: false);
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(
                    //   status == 1
                    //       ? Icons.
                    //       : Icons.warning_amber_outlined,
                    //   size: 100.0,
                    //   color: AppColors.mainColor,
                    // ),
                    Icon(
                       Icons.currency_exchange,
                      size: 100.0,
                      color: AppColors.mainColor,
                    ),
                    // Center(
                    //     child: Image.asset("img/oganime_drip_logo.jpg",
                    //         width: Dimensions.SPLASH_IMG_WIDTH1)),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Text(
                      status == 1
                          ? 'Proceed the payment through'
                          : 'your_order_is_failed_to_place'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Text(
                      "WhatsApp",
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: Dimensions.PADDING_SIZE_LARGE,
                    //       vertical: Dimensions.PADDING_SIZE_SMALL),
                    //   child: Text(
                    //     status == 1 ? 'order_successful'.tr : 'order_failed'.tr,
                    //     style: robotoMedium.copyWith(
                    //         fontSize: Dimensions.fontSizeSmall,
                    //         color: Theme.of(context).disabledColor),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    // Center(child: MaterialButton(

                    //   height: 100,
                    //   minWidth: 400,
                    //   color: AppColors.mainColor,
                    //   child: Center(),
                    //   onPressed: () {
                    //     FlutterOpenWhatsapp.sendSingleMessage(
                    //         "9353979275", "");
                    //   },
                    //   // child: Text('Running on: $_platformVersion\n'),
                    // )),
                    GestureDetector(
                      onTap: () {
                        FlutterOpenWhatsapp.sendSingleMessage("9353979275", "");
                      },
                      child: Container(
                        width: Dimensions.width180,
                        height: Dimensions.height55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: 'Click Here',
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
