import 'package:flutter/material.dart';
import 'package:imc_flutter/models/imc.dart';
import 'package:imc_flutter/pages/widgets/imc_form.dart';
import 'package:imc_flutter/pages/widgets/my_drawer.dart';
import 'package:imc_flutter/repositories/imc_repository.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});
  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  late ImcRepository imcRepository;
  List<Imc> _imcs = [];

  @override
  void initState() {
    _listarImcs();
    super.initState();
  }

  void _listarImcs() async {
    imcRepository = await ImcRepository.carregar();
    setState(() {
      _imcs = imcRepository.listar();
    });
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
      drawer: const MyDrawer(),
      body: (_imcs.isEmpty) ?
          const Padding(
            padding:  EdgeInsets.all(16.0),
            child: Center(
              child: Text("Ainda não existem IMCs adicionados. Adicione um IMC pressionando o botão do canto inferior direito e em seguida digite o peso.", textAlign: TextAlign.justify,),
            ),
          ) : ListView.separated(
          separatorBuilder: (BuildContext bc, i) => const Divider(),
          itemCount: _imcs.length,
          itemBuilder: (BuildContext bc, i) {
            var imc = _imcs[i];
            return Dismissible(
                key: Key(imc.id),
                onDismissed: (direction) async {
                  await imcRepository.remover(imc);
                  _listarImcs();
                },
                direction: DismissDirection.endToStart,
                child: ListTile(
                  leading: Text("${imc.date.day}/${imc.date.month}/${imc.date.year}"),
                  title: Text(imc.resultadoImc),
                  trailing: Text("Peso: ${imc.peso.toStringAsFixed(0)} kg"),
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
