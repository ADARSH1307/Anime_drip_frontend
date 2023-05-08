
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/reviews/reviewModal.dart';



const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

const String pieChart = 'assets/images/pieChart.png';
const String trophy = 'assets/images/trophy.png';
const String chat = 'assets/images/chat.png';
const String whiteShape = 'assets/images/whitebg.svg';
const String logo = 'assets/images/shoppingBag.png';
const String profile = 'assets/images/profile.jpg';
const String bg = 'assets/images/background.jpg';
const String manShoes = 'assets/images/manShoes.jpg';
const String success = 'assets/images/success.gif';
const String chatBubble = 'assets/images/emptyChat.png';
const String emptyOrders = 'assets/images/orders.png';
const String callCenter = 'assets/images/center.png';
const String conversation = 'assets/images/conversation.png';

List<Map<String, String>> introData = [
  {
    'image': pieChart,
    'headText': 'Track your routine',
    'descText':
        "Whether it's sets, reps, weight used, you can track it all with our intuitive interface.",
  },
  {
    'image': trophy,
    'headText': 'Set personal goals',
    'descText':
        "We're all in the gym for a reason: goals. set goals for diet and fitness.",
  },
  {
    'image': chat,
    'headText': 'Chat with others',
    'descText': "Inspire and help each other reach fitness and diet goals.",
  },
];

final labels = [
  'Notifications',
  'Payments',
  'Message',
  'My Orders',
  'Setting Account',
  'Call Center',
  'About Application',
];

final icons = [
  Icons.notifications,
  Icons.payment,
  Icons.message,
  Icons.local_dining,
  Icons.settings,
  Icons.person,
  Icons.info,
];

final paymentLabels = [
  'Credit card / Debit card',
  'Cash on delivery',
  'Paypal',
  'Google wallet',
];

final paymentIcons = [
  Icons.credit_card,
  Icons.money_off,
  Icons.payment,
  Icons.account_balance_wallet,
];

final settingLabel = [
  'Account',
  'Address',
  'Telephone',
  'Email',
  'Setting',
  'Order Notifications',
  'Discount Notifications',
  'Credit Card',
  'Logout',
];

List<String> chipsMobile = [
  "IPhone",
  "Samsung",
  "OnePlus",
  "RealMe",
  "Xiomi",
  "Oppo",
  "Vivo",
];

List<String> chipsCategory = [
  "Mobiles",
  "Cloths",
  "Electronics",
  "Furnitures",
  "Shoes",
  "Laptops",
  "Watches",
];

final List<String> sliderImages = [
  "assets/images/books.jpg",
  "assets/images/cameras.jpg",
  "assets/images/mensShoes.jpg",
  "assets/images/watches.jpg",
  "assets/images/headphones.jpg",
  "assets/images/girlsFootwear.jpg",
  "assets/images/joysticks.jpg",
  "assets/images/desktop.jpg",
  "assets/images/gymEquipments.jpg",
];

final menuLabels = [
  'Camera',
  "Furniture",
  'Headphone',
  'Gaming',
  'Fashion',
  'Health Care',
  'Computer',
  'Equipment',
  'Sport',
  'Ticket',
  'Books',
  'Cloths',
];

final menuIcons = [
  Icons.camera,
  Icons.home,
  Icons.headset,
  Icons.games,
  Icons.format_shapes,
  Icons.healing,
  Icons.computer,
  Icons.equalizer,
  Icons.gamepad,
  Icons.traffic,
  Icons.book,
  Icons.collections,
];




 

final reviewList = [
  ReviewModal(
    image: "assets/images/mensFashion.jpg",
    name: "John Travolta",
    rating: 3.5,
    date: "01 Jan 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/girlsFashion.jpg",
    name: "Scarlett Johansson",
    rating: 2.5,
    date: "21 Feb 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user1.jpg",
    name: "Jennifer Lawrence",
    rating: 4.5,
    date: "17 Mar 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user11.jpg",
    name: "Michael Jordan",
    rating: 1.5,
    date: "12 Apr 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ),
  ReviewModal(
    image: "assets/images/user2.jpg",
    name: "Nicole Kidman",
    rating: 2.0,
    date: "28 May 2021",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user10.jpg",
    name: "James Franco",
    rating: 4.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user3.jpg",
    name: "Margot Robbie",
    rating: 1.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user9.jpg",
    name: "Nicolas Cage",
    rating: 3.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user4.jpg",
    name: "Emma Stone",
    rating: 5.0,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user8.jpg",
    name: "Johnny Depp",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user5.jpg",
    name: "Natalie Portman",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user7.jpg",
    name: "Anne Hathaway",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user6.jpg",
    name: "Charlize Theron",
    rating: 3.5,
    date: "14 Nov 2020",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
];

