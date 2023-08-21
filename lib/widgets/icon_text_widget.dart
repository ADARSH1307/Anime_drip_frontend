import 'package:flutter/cupertino.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  IconAndTextWidget(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF76c5bb),
      this.iconColor = const Color(0xFF93ddd4),
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.height10 * 3,
        ),
        SizedBox(
          width: Dimensions.width10 / 2,
        ),
        TextWidget(
          text: text,
          color: color,
          size: Dimensions.height20,
        ),
      ],
    );
  }
}
