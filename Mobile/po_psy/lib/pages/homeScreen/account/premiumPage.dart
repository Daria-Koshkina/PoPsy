import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/User.dart';
import 'package:po_psy/models/UserHandler.dart';
import 'package:po_psy/pages/consultations/Consultations.dart';
import 'package:po_psy/pages/homeScreen/account/editProfile.dart';
import 'package:po_psy/pages/homeScreen/account/settings.dart';
import 'package:po_psy/widgets/Logo.dart';
import 'package:share/share.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;

  //this client secret is typically created by a backend system
  //check https://stripe.com/docs/payments/payment-intents#passing-to-client
  final String _paymentIntentClientSecret = null;

  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();
  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_aSaULNS8cJU6Tvo20VAXy6rp",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.lightGreyColor,
        body:  ListView(
          children: <Widget>[
            _logoElem(context),
            _premium(),
            Stack(
                children : <Widget> [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0, 1],
                        colors: [ColorPallet.lightBlueColor, ColorPallet.mainColor,],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0,),
                          topLeft: Radius.circular(10.0)),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child:
                      Text("Subscribe",
                          style: TextStyles.lightHeaderTextStyle)
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                          top: 50, left: 90, right: 90),
                      child:
                      IconButton(
                          iconSize: 70.0,
                          icon: Icon(
                          Icons.payment,
                            color: Colors.white
                          ),
                          onPressed: () {

                            if (Platform.isIOS) {
                              _controller.jumpTo(450);
                            }
                            StripePayment.paymentRequestWithNativePay(
                              androidPayOptions: AndroidPayPaymentRequest(
                                totalPrice: "0",
                                currencyCode: "EUR",
                              ),
                              applePayOptions: ApplePayPaymentOptions(
                                countryCode: 'DE',
                                currencyCode: 'EUR',
                                items: [
                                  ApplePayItem(
                                    label: 'Test',
                                    amount: '0',
                                  )
                                ],
                              ),
                            ).then((token) {
                              setState(() {
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('Received ${token.tokenId}')));
                                _paymentToken = token;
                              });
                            }).catchError(setError);
                          }
                      )
                  ),
                ]
            ),
          ],
        )
    );
  }
}

Widget _premium() {
  return ListTile(
    title: Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child:
      Text("Premium version grants users an opportunity to find their psychologist of choice, contact them and organize private consultations where they can talk over their issues with a highly qualified specialist and receive meaningful tips from them.",
      style: TextStyles.articleAuthorTextStyle
      )
    ),
  );
}

Widget _logoElem(BuildContext context){
  return Stack(
      children: <Widget>[
        Container(
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0, 1],
              colors: [ColorPallet.lightBlueColor, ColorPallet.mainColor,],
            ),
          ),
        ),
        Container(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              ),
            )
        ),
        Center(
          child: Logo(),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 15),
          child: Text(
              "Premium",
              style: TextStyles.lightHeaderTextStyle
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(left: 25, top: 220),
          child: Text(
              "Additional feature \nselection starting with \n&5.00",
              style: TextStyles.lightHeaderTextStyle
          ),
        ),
      ]
  );
}



