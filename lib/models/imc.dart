class IMC {
  double _peso;
  double _altura;

  IMC(this._peso, this._altura);

  double calculaIMC() {
    return _peso / (_altura * _altura);
  }

  String resultadoIMC() {
    double imc = calculaIMC();
    if (imc < 16) {
      return "magreza grave";
    } else if (imc < 17) {
      return "magreza moderada";
    } else if (imc < 18.5) {
      return "magreza leve";
    } else if (imc < 25) {
      return "saudável";
    } else if (imc <= 30) {
      return "sobrepeso";
    } else if (imc < 35) {
      return "obesidade grau I";
    } else if (imc < 40) {
      return "obesidade grau II (severa)";
    } else {
      return "obesidade grau III (mórbida)";
    }
  }
}