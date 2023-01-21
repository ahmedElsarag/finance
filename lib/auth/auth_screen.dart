import 'package:finance/chart/chart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/biometrics_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    BiometricsAuthUtils.authenticate().then((value){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>const ChartScreen()), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.20),
        child: Column(
          children: <Widget>[
            Lottie.asset('assets/lottie/finger-print.json',height: MediaQuery.of(context).size.height*0.20),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            const Text(
              'Authenticate to continue',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
