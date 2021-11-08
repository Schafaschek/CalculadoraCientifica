import 'package:calculadora_cien/calculadora/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);
  runApp(MaterialApp(
    home: homepage(),
    debugShowCheckedModeBanner: false,
  ));
}
