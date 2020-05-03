import 'package:flutter/material.dart';
import 'package:quake/components/constants.dart';
import 'package:quake/components/buttons.dart';
import 'package:quake/components/music_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quake/models/quake_brain.dart';

class Player extends StatefulWidget {
  static const String id = 'player';

  int songNumber;

  Player({@required this.songNumber});

  @override
  _PlayerState createState() => _PlayerState(songNumber: songNumber);
}

class _PlayerState extends State<Player> {
  _PlayerState({@required this.songNumber});

  int songNumber;
  bool pause = true;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    String songPath = playList[songNumber].songPath;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String songTitle = playList[songNumber].songName;
    String artistName = playList[songNumber].artistName;

    return Container(
      child: Stack(children: <Widget>[
        Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          Expanded(
            child: Container(
              color: primary_pink,
            ),
          ),
          Expanded(
            child: Container(
              color: primary_black,
            ),
          )
        ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _launchURL(playList[songNumber].youtubeURL);
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage("assets/images/egg.jpg"),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-10.0, 10.0),
                      color: Color(0x33000000),
                      blurRadius: 10.0,
                      spreadRadius: 10.0)
                ],
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/Highway_To_Hell.jpg"),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              songTitle,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'Source Sans Pro',
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 10.0),
            Text(
              artistName,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 40.0),
            Text(
              'Current Time',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 60.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      setState(() {
                        pause=!pause;
                      });
                    },
                    child:pause
                      ? PauseButton()
                      : PlayButton()
                  )
              
                ]),
            SizedBox(height: 60.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[VolumeDown(), MusicSlider(), VolumeUp()]),
          ],
        )),
      ]),
    );
  }
}
