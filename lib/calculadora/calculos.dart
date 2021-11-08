double calculos(double valor1, double valor2, String operator) {
  double valorF = 0;
  switch (operator) {
    case '+':
      return valorF = valor1 + valor2;
    case '-':
      return valorF = valor1 - valor2;
    case '*':
      return valorF = valor1 * valor2;
    case '/':
      return valorF = valor1 / valor2;
  }
}
