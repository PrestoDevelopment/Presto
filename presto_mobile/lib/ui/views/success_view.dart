import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class SuccessPage extends StatefulWidget {
  final TransactionModel transaction;

  SuccessPage({this.transaction});

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Success!',
                        style: TextStyle(
                          color: color.color1,
                          fontSize: 45.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 8,
                    child: RotationTransition(
                      turns: _animation,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/greentick.jpg',
                          colorBlendMode: BlendMode.clear,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Details:',
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
            Texts(
              text: 'Lender Name: ${widget.transaction.lenderName}',
              fontSize: 20.0,
            ),
            Texts(
              text: 'Lender Contact No.: ${widget.transaction.lenderContact}',
              fontSize: 20.0,
            ),
            Texts(
              text: 'Lending Amount: ${widget.transaction.amount}',
              fontSize: 20.0,
            ),
            Texts(
              text: 'Date: ${widget.transaction.initiationDate}',
              fontSize: 20.0,
            )
          ],
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  final String text;
  final double fontSize;

  Texts({@required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: fontSize),
      ),
    );
  }
}
