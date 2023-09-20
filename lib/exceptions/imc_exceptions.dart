class AlturaInvalidaException implements Exception {
  String error() => "Altura inválida, Precisa ser maior que zero.";
}

class PesoInvalidoException implements Exception {
  String error() => "Peso inválido, Precisa ser maior que zero.";
}