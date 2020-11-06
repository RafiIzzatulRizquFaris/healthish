import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/guide_contract.dart';
import 'package:healthish/login.dart';
import 'package:healthish/presenter/guide_presenter.dart';

class Guide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuideScreen();
  }
}

class GuideScreen extends State<Guide> implements GuideContractView {
  PageController pageController;
  GuidePresenter guidePresenter;
  List<DocumentSnapshot> listGuide = List<DocumentSnapshot>();
  bool loadingGuide = true;
  int lastIndex = 0;
  int currentPage = 0;

  GuideScreen() {
    guidePresenter = GuidePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    guidePresenter.loadGuideData();
    pageController = PageController(viewportFraction: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: Constants.darkGreyColor,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
      body: loadingGuide
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              ),
            )
          : PageView.builder(
              itemBuilder: itemBuilderGuideScreen,
              onPageChanged: onGuideScreenChange,
              controller: pageController,
              itemCount: listGuide.length,
            ),
      bottomNavigationBar: Container(
        color: Constants.whiteColor,
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: bottomButtonController(),
        ),
      ),
    );
  }

  Widget itemBuilderGuideScreen(BuildContext context, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            listGuide[index]['image'],
            loadingBuilder: (context, widget, imageLoad) {
              if (imageLoad == null) {
                return widget;
              }
              return CircularProgressIndicator(
                backgroundColor: Constants.blueColor,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 60,
              right: 60,
              bottom: 30,
            ),
            child: Text(
              listGuide[index]['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 30,
              left: 60,
              right: 60,
            ),
            child: Text(
              listGuide[index]['description'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.greyColorGuide,
                fontSize: 16,
              ),
            ),
          ),
          index == lastIndex
              ? FlatButton(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.exit_to_app_rounded,
                    color: Constants.whiteColor,
                    size: 25,
                  ),
                  shape: CircleBorder(),
                  color: Constants.blueColor,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                )
              : FlatButton(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Constants.whiteColor,
                    size: 25,
                  ),
                  shape: CircleBorder(),
                  color: Constants.blueColor,
                  onPressed: () {
                    pageController.nextPage(
                        duration: Duration(
                          milliseconds: 250,
                        ),
                        curve: Curves.easeOut);
                  },
                )
        ],
      ),
    );
  }

  @override
  onErrorGuideData(error) {
    // TODO: implement onErrorGuideData
    throw UnimplementedError();
  }

  @override
  onSuccessGuideData(List<DocumentSnapshot> value) {
    setState(() {
      listGuide = value;
      lastIndex = value.length - 1;
      loadingGuide = false;
    });
  }

  List<Widget> bottomButtonController() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listGuide.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          print("index : $i");
          pageController.animateToPage(
            i,
            duration: Duration(
              milliseconds: 250,
            ),
            curve: Curves.easeOut,
          );
        },
        child: Container(
          margin: EdgeInsets.all(10),
          width: 50,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: i == currentPage
                ? Constants.blueColor
                : Constants.greyColorGuideIndicator,
          ),
        ),
      ));
    }
    return list;
  }

  void onGuideScreenChange(int value) {
    setState(() {
      currentPage = value;
    });
  }
}
