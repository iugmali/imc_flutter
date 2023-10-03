import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_flutter/services/shared_preferences_service.dart';
import 'package:imc_flutter/utils/regex_formatter.dart';

class ImcForm extends StatefulWidget {
  final void Function(double altura, double peso) save;
  const ImcForm(this.save, {super.key});

  @override
  State<ImcForm> createState() => _ImcFormState();
}

class _ImcFormState extends State<ImcForm> {
  var storage = SharedPreferencesService();
  final _pesoController = TextEditingController();

  void _submitForm() async {
    final peso = double.tryParse(_pesoController.text) ?? 0.0;
    if (peso <= 0) {
      return;
    }
    final altura = await storage.getAltura();
    widget.save(altura, peso);
    _pesoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar IMC'),
      content: Wrap(
        children: [
          TextField(
            controller: _pesoController,
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: <TextInputFormatter>[
              RegexFormatter(RegExp(r'[0-9][0-9]?[0-9]?')),
            ],
            decoration:
            const InputDecoration(label: Text('Peso (kg)')),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Calcular IMC'),
        ),
      ],
    );
  }
}