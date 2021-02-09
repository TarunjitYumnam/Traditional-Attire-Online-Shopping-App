import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/payment.dart';

class UpiPage extends StatefulWidget {
  @override
  _UpiPageState createState() => _UpiPageState();
}

class _UpiPageState extends State<UpiPage> {
  String eamount;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE75CEE),
          title: Center(child: Text("UPI Payment")),
        ),
        body: CustomPaint(
            painter: BackgroundColorform(),
            child: Stack(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Payment',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                    Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(
                                height: 120,
                              ),
                              TextFormField(
                                initialValue: "",
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    labelText: 'Enter Amount',
                                    labelStyle: TextStyle(color: Colors.black)),
                                validator: (val) => val.isEmpty
                                    ? 'Please enter your amount'
                                    : null,
                                onChanged: (val) => setState(() => eamount = val),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Proceed',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          FlatButton(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFB7F83E),
                                radius: 40,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.grey,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentPage(eamount: eamount)));
                                }
                              }),
                        ],
                      ),
                    )
                  ]))
            ])));
  }
}

class BackgroundColorform extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Color(0xFFF1C2F0);
    canvas.drawPath(mainBackground, paint);

    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.5);
    blueWave.quadraticBezierTo(sw * 0.5, sh * 0.45, sw * 0.2, 0);
    blueWave.close();
    paint.color = Colors.lightBlue.shade300;
    canvas.drawPath(blueWave, paint);

    Path skyBlue = Path();
    skyBlue.lineTo(sw, 0);
    skyBlue.lineTo(sw, sh * 0.1);
    skyBlue.cubicTo(
        sw * 0.95, sh * 0.15, sw * 0.65, sh * 0.15, sw * 0.6, sh * 0.38);
    skyBlue.cubicTo(sw * 0.52, sh * 0.52, sw * 0.05, sh * 0.45, 0, sh * 0.4);
    skyBlue.close();
    paint.color = Color(0xFF3CE0C9);
    canvas.drawPath(skyBlue, paint);

    Path lightGreen = Path();
    lightGreen.lineTo(sw * 0.7, 0);
    lightGreen.cubicTo(
        sw * 0.6, sh * 0.05, sw * 0.27, sh * 0.01, sw * 0.18, sh * 0.12);
    lightGreen.quadraticBezierTo(sw * 0.12, sh * 0.2, 0, sh * 0.2);
    lightGreen.close();
    paint.color = Colors.greenAccent;
    canvas.drawPath(lightGreen, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}