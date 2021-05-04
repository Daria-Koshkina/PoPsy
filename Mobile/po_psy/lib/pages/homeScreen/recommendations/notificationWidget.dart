import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Notification.dart';

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
                      onPressed: (){},
                      child: Text("Complete", style: TextStyles.notificationButtonTextStyle,)),
                ]
        )
    );
  }
}