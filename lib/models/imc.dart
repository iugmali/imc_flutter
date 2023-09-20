import 'package:flutter/material.dart';
import 'package:imc_flutter/exceptions/imc_exceptions.dart';

class Imc {
  final String _id = UniqueKey().toString();
  double _peso;
  double _altura;

  Imc(this._peso, this._altura){
    _validate();
  }

  void _validate() {
    if (_peso <= 0) {
      throw PesoInvalidoException();
    }
    if (_altura <= 0) {
      throw AlturaInvalidaException();
    }
  }

  String get id => _id;
  double get peso => _peso;
  double get altura => _altura;

  double get imc => _peso / (_altura * _altura);

  String get resultadoImc {
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