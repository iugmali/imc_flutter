import 'package:flutter/material.dart';

class ImcForm extends StatefulWidget {
  final void Function(double altura, double peso) save;
  const ImcForm(this.save, {super.key});

  @override
  State<ImcForm> createState() => _ImcFormState();
}

class _ImcFormState extends State<ImcForm> {
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  _submitForm() {
    final altura = double.tryParse(_alturaController.text) ?? 0.0;
    final peso = double.tryParse(_pesoController.text) ?? 0.0;
    if (altura <= 0 || peso <= 0) {
      return;
    }
    widget.save(altura, peso);
    _alturaController.clear();
    _pesoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar IMC'),
      content: Column(
        children: [
          TextField(
            controller: _alturaController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration:
            const InputDecoration(label: Text('Altura (m)')),
          ),
          TextField(
            controller: _pesoController,
            keyboardType: const TextInputType.numberWithOptions(),
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