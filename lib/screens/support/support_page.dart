import 'package:flutter/material.dart';

import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:shopping_app/components/colors.dart';



class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Anime Drip Support'),
          backgroundColor:AppColors.mainColor,
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/645b4817ad80445890ec1b68/1h02937dj',
          visitor: TawkVisitor(
            name: 'Adarsh',
            email: 'adarshajila1307@gmail.com',
          ),
          onLoad: () {
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}