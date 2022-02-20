import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterprojet/qr_code/intances.dart';
import 'package:flutterprojet/qr_code/qr_code.dart';
import 'package:flutterprojet/qr_code/qr_code_screen.dart';
import 'constant.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(

          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
          )),
      home: const InfoScreen(
        title: 'Qr Code Scanner',
      ),
    );
  }

}

class InfoScreen extends StatefulWidget {

  const InfoScreen({Key? key, required this.title})
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
  State<InfoScreen> createState() => HomeScreen();
}
class HomeScreen extends State<InfoScreen>{


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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            MaterialPageRoute(
                                builder: (context) =>
                                const MyHomePage(title: "Qr Code Scanner")// bash neb9aw mashin raj3in n pagina lewla
                            ),
                          );
                        },
                          child: SvgPicture.asset("assets/icons/menu.svg")),
                    ),
                    SizedBox(height: 20),
                    Expanded(child: Stack(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/coronadr.svg",
                          width: 280,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                          top: 30,
                            left: 170,
                            child: Text(
                              "Get to know \nAbout Covid-19",
                              style: kHeadingTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                        ),
                        Container(),
                    ],
                    ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(
                  "Symptoms",
                style: kTitleTextstyle,
              ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: kActiveShadowColor,
                            ),
                     ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/headache.png", height: 90),
                            Text(
                              "Headache",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: kActiveShadowColor,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/caugh.png", height: 90),
                            Text(
                              "Caugh",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: kActiveShadowColor,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/fever.png", height: 90),
                            Text(
                              "Fever",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Prevention", style: kTitleTextstyle),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 156,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            height: 136,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0,8),
                                  blurRadius: 24,
                                  color: kShadowColor,
                              ),
                              ],
                            ),
                          ),
                          Image.asset("assets/images/wear_mask.png"),
                          Positioned(
                            left: 130,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                height: 136,
                                width: MediaQuery.of(context).size.width - 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Wear face mask",
                                      style: kTitleTextstyle.copyWith(
                                          fontSize: 16),
                                  ),
                                    Text("Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                        child: SvgPicture.asset(
                                            "assets/icons/forward.svg"),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ],
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 156,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            height: 136,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0,8),
                                  blurRadius: 24,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                          ),
                          Image.asset("assets/images/wash_hands.png"),
                          Positioned(
                            left: 130,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              height: 136,
                              width: MediaQuery.of(context).size.width - 170,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Wash your hands",
                                    style: kTitleTextstyle.copyWith(
                                        fontSize: 16),
                                  ),
                                  Text("Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: SvgPicture.asset(
                                        "assets/icons/forward.svg"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
              ),
            )
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
  }
