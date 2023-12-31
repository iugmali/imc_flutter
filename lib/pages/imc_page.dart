import 'package:flutter/material.dart';
import 'package:imc_flutter/models/imc.dart';
import 'package:imc_flutter/repositories/imc_repository.dart';
import 'package:imc_flutter/widgets/imc_form.dart';
import 'package:imc_flutter/widgets/my_drawer.dart';

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
    return SafeArea(
      child: Scaffold(
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
              String formattedDate = "${(imc.date.day < 10) ? '0${imc.date.day}' : imc.date.day}/${imc.date.month}/${imc.date.year}";
              return Dismissible(
                  key: Key(imc.id),
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Remover Registro"),
                            content: const Text("Deseja remover o registro de IMC salvo?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancelar')
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Remover IMC'),
                              ),
                            ],
                          );
                        });
                  },
                  onDismissed: (direction) async {
                    imcRepository.remover(imc);
                    _listarImcs();
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(decoration: const BoxDecoration(
                      gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.redAccent,
                        Colors.red,
                      ],
                      stops: [
                      0.15,
                      0.90,
                      ]),
                    ),
                  ),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Text(formattedDate),
                      title: Text(imc.resultadoImc),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Altura: ${imc.altura.toStringAsFixed(2).replaceAll('.', ',')}m"),
                          Text("Peso: ${imc.peso.toStringAsFixed(0)}kg"),
                        ],
                      ),
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
      ),
    );
  }
}
