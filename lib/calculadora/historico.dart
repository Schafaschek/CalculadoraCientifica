import 'package:calculadora_cien/banco_dados/bd.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_cien/calculadora/constantes.dart';

class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  List<Resultado> lResultado = List();
  ArmazenaConta pegaC = ArmazenaConta();
  void _getAllResults() {
    pegaC.getAllResultados().then((list) {
      setState(() {
        lResultado = list;
        print(lResultado);
      });
    });
  }

  void initState() {
    super.initState();
    _getAllResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Histórico'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhas,
            itemBuilder: (BuildContext context) {
              return Constantes.escolhas2.map((String escolhas) {
                return PopupMenuItem<String>(
                  value: escolhas,
                  child: Text(escolhas),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(235, 242, 247, 1),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: lResultado.length,
          itemBuilder: (context, index) {
            return _viewHistorico(context, index);
          }),
    );
  }

  Widget _viewHistorico(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        color: Color.fromRGBO(235, 242, 247, 1),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                          lResultado[index].valor1 ??
                              "" + lResultado[index].operator ??
                              "" + lResultado[index].valor2 ??
                              "" + lResultado[index].vTotal ??
                              "",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Text(lResultado[index].operator ?? "",
                        style: TextStyle(fontSize: 14.0)),
                    Text(lResultado[index].valor2 ?? "",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    Text('=',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text(
                      lResultado[index].vTotal ?? "",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _escolhas(String escolha) {
    if (escolha == 'Excluir Histórico') {
      //pegaC.deleteAll();
    }
  }
}
