import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class homepage extends StatefulWidget {
  const homepage({key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calculadora Cientifica'),
      ),
      body: Column(
        children: <Widget>[
          _criaVisor(),
          Divider(height: 0.1),
          _criaTeclado(),
        ],
      ),
    );
  }

  Widget _criaVisor() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Color.fromRGBO(235, 242, 247, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "2",
                minFontSize: 20,
                maxFontSize: 100,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                  fontSize: 100,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _criaTeclado() {
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaBotao('AC', backgroudColor: Colors.green.shade100),
                _criaBotao('()', backgroudColor: Colors.lightBlue.shade100),
                _criaBotao('%', backgroudColor: Colors.lightBlue.shade100),
                _criaBotao('PH', backgroudColor: Colors.lightBlue.shade100)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaBotao('7', backgroudColor: Colors.grey.shade100),
                _criaBotao('8', backgroudColor: Colors.grey.shade100),
                _criaBotao('9', backgroudColor: Colors.grey.shade100),
                _criaBotao('x', backgroudColor: Colors.lightBlue.shade100)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaBotao('4', backgroudColor: Colors.grey.shade100),
                _criaBotao('5', backgroudColor: Colors.grey.shade100),
                _criaBotao('6', backgroudColor: Colors.grey.shade100),
                _criaBotao('-', backgroudColor: Colors.lightBlue.shade100)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaBotao('1', backgroudColor: Colors.grey.shade100),
                _criaBotao('2', backgroudColor: Colors.grey.shade100),
                _criaBotao('3', backgroudColor: Colors.grey.shade100),
                _criaBotao('+', backgroudColor: Colors.lightBlue.shade100)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaBotao('0', backgroudColor: Colors.grey.shade100),
                _criaBotao('.', backgroudColor: Colors.grey.shade100),
                _criaBotao('PH', backgroudColor: Colors.grey.shade100),
                _criaBotao('=', backgroudColor: Colors.deepPurple.shade100)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _criaBotao(String label,
      {int flex: 1,
      Color textColor = Colors.black,
      Color backgroudColor = Colors.grey}) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(backgroudColor.value),
      onPrimary: Color(textColor.value),
    );
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        style: style,
        child: Text(
          label,
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
