import 'package:flutter_test/flutter_test.dart';
import 'package:imc_flutter/exceptions/imc_exceptions.dart';
import 'package:imc_flutter/models/imc.dart';

void main() {
  group("Imc model test", () {
    test('O IMC deve ser 25', () {
      var imc = Imc(100, 2);
      expect(imc.imc, 25);
    });
    test('Resltado do IMC deve ser obesidade grau I', () {
      var imc = Imc(105, 1.77);
      expect(imc.resultadoImc, "obesidade grau I");
    });
    test('Deve retornar AlturaInvalidaException', () => {
      expect(() {
        var imc = Imc(100, 0);
      }, throwsA(isA<AlturaInvalidaException>()))
    });
    test('Deve retornar PesoInvalidoException', () => {
      expect(() {
        var imc = Imc(0, 2);
      }, throwsA(isA<PesoInvalidoException>()))
    });
  });
}