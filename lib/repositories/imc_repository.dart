import 'package:hive/hive.dart';
import 'package:imc_flutter/models/imc.dart';

const IMC_MODEL = "imcModel";

class ImcRepository {
  static late Box _box;

  ImcRepository._criar();

  static Future<ImcRepository> carregar() async {
    if (Hive.isBoxOpen(IMC_MODEL)) {
      _box = Hive.box(IMC_MODEL);
    } else {
      _box = await Hive.openBox(IMC_MODEL);
    }
    return ImcRepository._criar();
  }

  adicionar(Imc imc) async {
    _box.add(imc);
  }

  remover(Imc imc) async {
    imc.delete();
  }

  List<Imc> listar() {
      return _box.values
          .cast<Imc>()
          .toList();
  }

}