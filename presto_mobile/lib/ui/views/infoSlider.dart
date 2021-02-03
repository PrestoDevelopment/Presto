import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/views/main_view.dart';

class InfoSlider extends StatefulWidget {
  @override
  _InfoSliderState createState() => _InfoSliderState();
}

class _InfoSliderState extends State<InfoSlider> {
  List<SliderModel> mySlides = List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  NavigationService _navigationService = locator<NavigationService>();

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mySlides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Text("Info Slider"),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff3C8CE7),
            const Color(0xff00EAFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(
                () {
                  slideIndex = index;
                },
              );
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySlides[0].getImageAssetPath(),
                title: mySlides[0].getTitle(),
                desc: mySlides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySlides[1].getImageAssetPath(),
                title: mySlides[1].getTitle(),
                desc: mySlides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySlides[2].getImageAssetPath(),
                title: mySlides[2].getTitle(),
                desc: mySlides[2].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        ///Navigate to Main Page
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MainPageView(),
                            settings: RouteSettings(
                              name: MainPageViewRoute,
                            ),
                          ),
                        );
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                            color: color.color1, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        print("this is slideIndex: $slideIndex");
                        controller.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: color.color1, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  ///Navigate to MAinPage
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MainPageView(),
                      settings: RouteSettings(
                        name: MainPageViewRoute,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Platform.isIOS ? 70 : 60,
                  color: color.color1,
                  alignment: Alignment.center,
                  child: Text(
                    "GET STARTED NOW",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
        ],
      ),
    );
  }
}

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("We are committed to build strong communities on mutual trust and support");
  sliderModel.setTitle("Why Presto Exists");
  sliderModel.setImageAssetPath("assets/images/firstImage.jpeg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "A highly innovative invite-only community based P2P lending platform disbursing small loans in a matter of 30 seconds");
  sliderModel.setTitle("What Presto Does");
  sliderModel.setImageAssetPath("assets/images/secondImage.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "You can borrow from your fellow community members by placing a request on the 'Borrow Now' screen & lend by accepting a borrowing request");
  sliderModel.setTitle("How Presto Work");
  sliderModel.setImageAssetPath("assets/images/thirdImage.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
