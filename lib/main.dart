import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterprojet/constant.dart';
import 'package:flutterprojet/info_screen.dart';
import 'package:flutterprojet/qr_code/intances.dart';
import 'package:flutterprojet/qr_code/qr_code.dart';
import 'package:flutterprojet/qr_code/qr_code_screen.dart';
import 'package:flutterprojet/qr_code/main.dart' as qr_list;
import 'dart:convert' as convert;
import 'package:flutterprojet/FCM/helper.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      localeResolutionCallback: (
          Locale? locale,
          Iterable<Locale> supportedLocales,
          ) {
        return locale;
      },
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fr', ''),
        Locale('en', ''),
      ],
      theme: ThemeData(

        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kBodyTextColor),
        )),
      home: const MyHomePage(
        title: 'Qr Code Scanner',
      ),
    );
  }

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => HomeScreen();
}
class HomeScreen extends State<MyHomePage>{

  Map<String, dynamic> data = Map<String, dynamic>();

  Future<void> _sendData() async {
    showLoader(context);
    var url = Uri.parse(
        'https://corona.lmao.ninja/v2/countries/Morocco?yesterday=false&strict=true&query =');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        this.data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(this.data);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    hideLoader(context);
  }




  @override
  void initState() {
    super.initState();
    myData.initDb(callbackList);
  }

  void _addQrCode() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeScreen(callback: callback)),
    );
  }

  void callback(MyQrCode qrCode) {
    setState(() {
      myData.qrCodes?.add(qrCode);
    });
  }

  void callbackList(List<MyQrCode> qrCodes) {
    setState(() {
      myData.qrCodes = qrCodes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ],
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                            const InfoScreen(title: "Qr Code Scanner")
                        ),
                        );
                        },
                          child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(child: Stack(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/Drcorona.svg",
                          width: 230,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                          top: 20,
                          left: 150,
                          child: Text(
                            "All you need  \nis stay at home",
                            style: kHeadingTextStyle.copyWith(color: Colors.white,
                            ),
                          ),
                        ),
                        Container(),
                        //obliger de travailler avec container parcequ'il ne fonctionne pas
                      ],
                    ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: "Morocco",
                      items: ['Morocco', 'france', 'Spain']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Case Update\n",
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: "Newest update january 14",
                            style: TextStyle(
                              color: kTextLightColor,
                          ),
                          ),
                        ],
                  ),
                  ),
                    Spacer(),
                      TextButton(
                      child: Text('see details', style: TextStyle(fontSize: 20.0),),
                      onPressed: _sendData,
                    ),
                  ],

                ),
                SizedBox(height: 20),
                Container(padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: kShadowColor,
                    ),
                    ],
                  ),
                  child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 8.0, // gap between lines
                    direction: Axis.horizontal, // main axis (rows or columns)
                    children: <Widget>[
                      Column(
                  children: <Widget>[
                  Container(
                  padding: EdgeInsets.all(6),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kInfectedColor.withOpacity(.26),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: kInfectedColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(data['cases'].toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: kInfectedColor,
                  ),
                ),
                Text(AppLocalizations.of(context)!.totalcases, style: kSubTextStyle),
                      ],
                  ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kInfectedColor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kInfectedColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['todayCases'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kInfectedColor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.todaycases, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kDeathColor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kDeathColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['deaths'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kDeathColor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.totaldeaths, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kDeathColor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kDeathColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['todayDeaths'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kDeathColor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.todaydeaths, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kRecovercolor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kRecovercolor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['recovered'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kRecovercolor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.totalrecovered, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kRecovercolor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kRecovercolor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['todayRecovered'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kRecovercolor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.todayrecovered, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['tests'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.totaltests, style: kSubTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor.withOpacity(.26),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(data['testsPerOneMillion'].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(AppLocalizations.of(context)!.testsmillion, style: kSubTextStyle),
                        ],
                      ),
                  ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) =>
                          qr_list.MyHomePage(title: "Qr Code Scanner")),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.mywallet),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text(
                    "Spread of virus",
                    style: kTitleTextstyle,
                  ),
                  Text(
                    "See details",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  height: 178,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 10),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/map.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _addQrCode,
      tooltip: 'New QrCode',
      child: const Icon(IconData(0xf00cc, fontFamily: 'MaterialIcons')),
    ),
    );
  
  }
  initData() async {
    var url = Uri.parse(
        'https://corona.lmao.ninja/v2/countries/Morocco?yesterday=false&strict=true&query =');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        this.data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width/2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
  
}