import 'dart:async';
import 'dart:math';

import 'package:ChatGPT/views/Authentication/auth.dart';
import 'package:ChatGPT/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'models/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat GPT',
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> texts = [
    "Chat GPT",
    "Let's Design",
    "Let's Discover",
    "Let's Collaborate",
    "Let's Explore",
    "Let's Chit-Chat"
  ];

  int currentIndex = 0;
  String displayedText = "";
  Color backgroundColor = Colors.blue; // Initial background color

  @override
  void initState() {
    super.initState();
    startTypingLoop();
  }

  void startTypingLoop() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      startTyping();
    });
  }

  void startTyping() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (texts[currentIndex].length > displayedText.length) {
        setState(() {
          displayedText =
              texts[currentIndex].substring(0, displayedText.length + 1);
        });
      } else {
        timer.cancel();
        Timer(Duration(seconds: 1), () {
          eraseText();
        });
      }
    });
  }

  void eraseText() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (displayedText.isNotEmpty) {
        setState(() {
          displayedText = displayedText.substring(0, displayedText.length - 1);
        });
      } else {
        timer.cancel();
        setState(() {
          currentIndex = (currentIndex + 1) % texts.length;
          backgroundColor = getRandomColor();
        });
        startTyping();
      }
    });
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.7,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              color: backgroundColor,
              child: Center(
                child: Text(
                  displayedText,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            color: backgroundColor,
            child: Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  color: MyColors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height*0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.greyShadow,
                          disabledBackgroundColor: MyColors.veryLightBlue,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Image.asset(
                                'assets/icons/google.png',
                                width: 50, // Set the desired width
                                height: 50, // Set the desired height
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 20
                              ),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.greyShadow,
                          disabledBackgroundColor: MyColors.veryLightBlue,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.greyShadow,
                          disabledBackgroundColor: MyColors.veryLightBlue,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
