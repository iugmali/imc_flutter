import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_flutter/pages/imc_page.dart';
import 'package:imc_flutter/services/shared_preferences_service.dart';
import 'package:imc_flutter/utils/regex_formatter.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  var storage = SharedPreferencesService();
  final _alturaController = TextEditingController();
  final _usernameController = TextEditingController();
  late String _username;
  late double _altura;

  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  _carregarDados() async {
    _usernameController.text = await storage.getUsername();
    double altura = await storage.getAltura();
    if (altura > 0) {
      _alturaController.text = altura.toString().replaceAll('.', ',');
    }
  }

  void _salvarDados() async {
    await storage.setUsername(_username);
    await storage.setAltura(_altura);
  }

  void _submitForm() {
    FocusManager.instance.primaryFocus?.unfocus();
    _altura = double.tryParse(_alturaController.text.replaceAll(',', '.')) ?? 0.0;
    if (_altura <= 0) {
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: const Text("Altura inválida"),
          content: const Wrap(
            children: [
              Text("A altura deve ser maior que zero."),
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
      return;
    }
    _username = _usernameController.text.trim();
    if (_username == "") {
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: const Text("Username inválido"),
          content: const Wrap(
            children: [
              Text("O nome de usuário não deve ser vazio."),
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
      return;
    }
    _salvarDados();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados salvos com sucesso'))
    );
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ImcPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              inputFormatters: <TextInputFormatter>[
                RegexFormatter(RegExp(r'[a-z]{1,16}')),
              ],
              decoration: const InputDecoration(label: Text('Nome de usuário')),
            ),
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: <TextInputFormatter>[
                RegexFormatter(RegExp(r'[0-2]([,.][0-9]*)?')),
                TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                    text: newValue.text.replaceAll('.', ','),
                  ),
                ),
              ],
              decoration: const InputDecoration(label: Text('Altura (m)')),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: _submitForm, child: const Text("Salvar"))
          ],
        ),
      ),
    );
  }
}
