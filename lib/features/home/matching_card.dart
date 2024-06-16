import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:facebook_clone/common/theme.dart'; // Ensure this import is correct

class MatchingCard extends StatefulWidget {
  final String name;
  final String imageURL;
  final int age;
  final String bio;
  final VoidCallback denyButton;
  final VoidCallback likeButton;

  const MatchingCard({
    Key? key,
    required this.name,
    required this.imageURL,
    required this.age,
    required this.bio,
    required this.denyButton,
    required this.likeButton,
  }) : super(key: key);

  @override
  _MatchingCardState createState() => _MatchingCardState();
}

class _MatchingCardState extends State<MatchingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(0.0, 5.0),
            blurRadius: 20.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 15.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: MediaQuery.of(context).size.height * 0.76,
            width: MediaQuery.of(context).size.width - 10.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(widget.imageURL),
              ),
            ),
          ),
          infoText(),
          Positioned(
            bottom: 1.0,
            right: -1.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 22.0,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black26],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          button() // Ensuring buttons are on top
        ],
      ),
    );
  }

  Widget infoText() {
    return Positioned(
      right: ScreenUtil().setWidth(20.0),
      bottom: ScreenUtil().setHeight(100.0), // Moved up to avoid overlap
      left: ScreenUtil().setWidth(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.name,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(25.0),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10.0),
              ),
              Text(
                widget.age.toString(),
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(25.0),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5.0),
          ),
          Text(
            widget.bio,
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 10.0,
                ),
              ],
              fontSize: ScreenUtil().setSp(18.0),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20.0),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Positioned(
      bottom: ScreenUtil().setHeight(20.0), // Positioning buttons at the bottom
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtil().setSp(60),
            height: ScreenUtil().setSp(60),
            child: ElevatedButton(
              onPressed: () {
                print('Deny button pressed');
                widget.denyButton();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                padding: EdgeInsets.all(0),
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.hand_thumbsdown_fill,
                  color: Color.fromARGB(255, 241, 197, 1),
                  size: ScreenUtil().setSp(32),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: ScreenUtil().setSp(45),
            height: ScreenUtil().setSp(45),
            child: ElevatedButton(
              onPressed: () {
                print('Bolt button pressed');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                padding: EdgeInsets.all(0),
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.bolt_fill,
                  color: Colors.blue,
                  size: ScreenUtil().setSp(25),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: ScreenUtil().setSp(60),
            height: ScreenUtil().setSp(60),
            child: ElevatedButton(
              onPressed: () {
                print('Like button pressed');
                widget.likeButton();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                shape: CircleBorder(),
                padding: EdgeInsets.all(0),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: AppTheme.primaryColor,
                  size: ScreenUtil().setSp(35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
