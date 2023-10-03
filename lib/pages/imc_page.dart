import 'package:flutter/material.dart';
import 'package:imc_flutter/models/imc.dart';
import 'package:imc_flutter/pages/widgets/imc_form.dart';
import 'package:imc_flutter/repositories/imc_repository.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});
  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var imcRepository = ImcRepository();
  List<Imc> _imcs = [];

  @override
  void initState() {
    _listarImcs();
    super.initState();
  }

  void _listarImcs() async {
    _imcs = await imcRepository.listar();
    if (mounted) {
      setState(() {});
    }
  }

  void _adicionaImcDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return ImcForm(_adicionaImc);
        });
  }

  void _adicionaImc(double altura, double peso) {
    final novoImc = Imc(
      peso,
      altura
    );
    imcRepository.adicionar(novoImc);
    _listarImcs();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      body: (_imcs.length == 0) ?
          const Padding(
            padding:  EdgeInsets.all(16.0),
            child: Center(
              child: Text("Ainda não existem IMCs adicionados. Adicione um IMC pressionando o botão do canto inferior direito e em seguida digite altura e peso.", textAlign: TextAlign.justify,),
            ),
          ) : ListView.separated(
          separatorBuilder: (BuildContext bc, i) => const Divider(),
          itemCount: _imcs.length,
          itemBuilder: (BuildContext bc, i) {
            var imc = _imcs[i];
            return Dismissible(
                key: Key(imc.id),
                onDismissed: (direction) async {
                  await imcRepository.remover(imc.id);
                  _listarImcs();
                },
                direction: DismissDirection.endToStart,
                child: ListTile(
                  title: Text(imc.resultadoImc),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Altura: ${imc.altura.toStringAsFixed(2).replaceAll('.', ',')}"),
                      Text("Peso: ${imc.peso.toStringAsFixed(0)}"),
                    ],
                  ),
                )
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar IMC',
        onPressed: _adicionaImcDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
