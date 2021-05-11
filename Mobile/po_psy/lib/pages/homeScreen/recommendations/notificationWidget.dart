import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/constants/stateConstants/NotificationStates.dart';
import 'package:po_psy/models/recommendationsModels/Notification.dart';
import 'package:po_psy/pages/homeScreen/diary/diary.dart';
import 'package:po_psy/pages/homeScreen/tests/tests.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationWidget extends StatelessWidget {
  final MyNotification notification;

  NotificationWidget({this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ColorPallet.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: new EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(notification.title,
                    style: TextStyles.lightHeaderTextStyle,),
                  SizedBox(height: 20,),
                  Text(
                    notification.text, style: TextStyles.lightCommonTextStyle,),
                  TextButton(
                      onPressed: (){
                        _manageNotification(notification, context);
                      },
                      child: Text("Manage", style: TextStyles.notificationButtonTextStyle,)),
                ]
        )
    );
  }
}

void _manageNotification(MyNotification notification, BuildContext context) {
  if (notification.URL == null) {
    return;
  }
  if (notification.URL == NotificationStates.tests) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TestsPage())
    );
  } else if (notification.URL == NotificationStates.diary) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiaryPage())
    );
  } else {
    _launchURL(notification.URL);
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}