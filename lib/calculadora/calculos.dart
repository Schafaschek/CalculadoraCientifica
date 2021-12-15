import 'package:calculadora_cien/banco_dados/bd.dart';
import 'dart:math';

class Calculo {
  static const operators = const [
    '%',
    '/',
    '+',
    '-',
    'x',
    '=',
    '^',
  ];

  static const operatorsE = const ['√', '!', 'Exp', 'sin', 'cos', 'tan', 'ln'];

  String _resultado = '0';
  final _nums = [0.0, 0.0];
  int _numIndex = 0;
  String _operator;
  bool _limpaValor = false;
  String _ultimoR;
  ArmazenaConta aC = ArmazenaConta();
  final double pi = 3.14159265359;

  void aplicarOp(String retorno) {
    if (retorno == 'π') {
      retorno = pi.toString();
    }
    if (_trocandoOp(retorno)) {
      _operator = retorno;
      return;
    }

    if (retorno == 'AC') {
      _apagaTudo();
    } else if (retorno == 'DEL') {
      _apagaUltimoDig();
    } else if (operatorsE.contains(retorno)) {
      _setOperatorEx(retorno);
    } else if (operators.contains(retorno)) {
      _setOperator(retorno);
    } else {
      _adicionaDigito(retorno);
    }

    _ultimoR = retorno;
  }

  _apagaUltimoDig() {
    _resultado = _resultado.length > 1
        ? _resultado.substring(0, _resultado.length - 1)
        : '0';

    _nums[_numIndex] = double.tryParse(_resultado);
  }

  _trocandoOp(String retorno) {
    return operators.contains(_ultimoR) &&
        operators.contains(retorno) &&
        _ultimoR != '=' &&
        retorno != '=';
  }

  _apagaTudo() {
    _resultado = '0';
    _nums.setAll(0, [0.0, 0.0]);
    _operator = null;
    _numIndex = 0;
    _limpaValor = false;
  }

  _setOperatorEx(String newOperation) {
    if (_numIndex == 0) {
      _nums[0] = calculosE(newOperation, _nums[0]);
      _limpaValor = true;
      _resultado = _nums[0].toString();
    } else if (_numIndex == 1) {
      _nums[1] = calculosE(newOperation, _nums[1]);
      _limpaValor = true;
      _resultado = _nums[1].toString();
    }
  }

  _setOperator(String newOperation) {
    bool isEqualSign = newOperation == '=';
    if (_numIndex == 0) {
      if (!isEqualSign) {
        _operator = newOperation;
        _numIndex = 1;
        _limpaValor = true;
      }
    } else {
      _nums[0] = calculos(_nums[0], _nums[1], _operator);
      _nums[1] = 0.0;
      _resultado = _nums[0].toString();
      _resultado =
          _resultado.endsWith('.0') ? _resultado.split('.')[0] : _resultado;
      _operator = isEqualSign ? null : newOperation;
      _numIndex = isEqualSign ? 0 : 1;
      _limpaValor = !isEqualSign;
    }
  }

  _adicionaDigito(String digito) {
    final tP = digito == '.';
    final limpaValor = (_resultado == '0' && !tP) || _limpaValor;

    if (tP && _resultado.contains('.') && !limpaValor) {
      return;
    }

    final valorV = tP ? '0' : '';

    final valorAtual = limpaValor ? valorV : _resultado;
    _resultado = valorAtual + digito;
    _limpaValor = false;

    _nums[_numIndex] = double.tryParse(_resultado) ?? 0;
  }

  String get resultado {
    return _resultado;
  }

  _salvarResultado(operator, valor1, valor2, valorF) {
    Resultado aCR = Resultado();
    aCR.operator = operator;
    aCR.valor1 = valor1.toString();
    aCR.valor2 = valor2.toString();
    aCR.vTotal = valorF.toString();
    aC.saveResultado(aCR);
  }

  double calculos(double valor1, double valor2, String operator) {
    double valorF = 0;
    Resultado aCR = Resultado();
    switch (operator) {
      case '+':
        valorF = valor1 + valor2;
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
      case '-':
        valorF = valor1 - valor2;
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
      case 'x':
        valorF = valor1 * valor2;
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
      case '/':
        valorF = valor1 / valor2;
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
      case '%':
        valorF = valor1 % valor2;
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
      case '^':
        valorF = pow(valor1, valor2);
        _salvarResultado(operator, valor1, valor2, valorF);
        return valorF;
    }
  }

  calculosE(String operatorE, double valor) {
    switch (operatorE) {
      case '√':
        valor = sqrt(valor);
        return valor;
      case '!':
        valor = funcFatorial(valor);
        return valor;
      case 'Exp':
        valor = exp(valor);
        return valor;
      case 'sin':
        valor = sin(valor);
        return valor;
      case 'tan':
        valor = tan(valor);
        return valor;
      case 'cos':
        valor = cos(valor);
        return valor;
      case 'ln':
        valor = log(valor);
        return valor;
    }
  }

  funcFatorial(double valor) {
    return (valor == 1 || valor == 0) ? 1 : valor * funcFatorial(valor - 1);
  }
}
