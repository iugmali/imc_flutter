import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_flutter/exceptions/imc_exceptions.dart';
import 'package:imc_flutter/pages/configuration_page.dart';
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
  late double _altura;

  @override
  void initState() {
    _carregarAltura();
    super.initState();
  }

  void _carregarAltura() async {
    _altura = await storage.getAltura();
  }

  void _submitForm() {
    final peso = double.tryParse(_pesoController.text) ?? 0.0;
    try {
      widget.save(_altura, peso);
      _pesoController.clear();
    } on PesoInvalidoException {
      FocusManager.instance.primaryFocus?.unfocus();
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: const Text("Peso inválido"),
          content: const Wrap(
            children: [
              Text("O peso deve ser maior que zero."),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  },
                child: const Text("OK"))
          ],
        );
      });
    } on AlturaInvalidaException {
      FocusManager.instance.primaryFocus?.unfocus();
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: const Text("Altura não configurada"),
          content: const Wrap(
            children: [
              Text(
                  "Configure username e altura através de configurações, no menu lateral"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigurationPage()));
              },
              child: const Text("Ir para as configurações"))
          ],
        );
      });
    }
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