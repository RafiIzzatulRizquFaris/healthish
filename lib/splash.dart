import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthish/constants.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController imageAnimationController;
  AnimationController textAnimationController;
  Animation imageAnimation;
  Animation textAnimation;

  @override
  void initState() {
    imageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
      value: 0.1,
    );
    textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ),
    );
    imageAnimation = CurvedAnimation(
      curve: Curves.easeInCirc,
      parent: imageAnimationController,
    );
    textAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: textAnimationController,
    );
    super.initState();
    imageAnimationController.forward();
    textAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/ambulance.png"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: imageAnimation,
                  child: Image.asset("assets/medical_icon.png"),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  width: 10,
                ),
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: textAnimation,
                  axis: Axis.horizontal,
                  child: Text(
                    "Healthish",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}