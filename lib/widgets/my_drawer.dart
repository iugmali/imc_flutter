import 'package:flutter/material.dart';
import 'package:imc_flutter/pages/configuration_page.dart';
import 'package:imc_flutter/services/shared_preferences_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var storage = SharedPreferencesService();
  String _username = "";
  String _altura = "Altura não configurada";

  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  _carregarDados() async {
    _username = await storage.getUsername();
    double altura = await storage.getAltura();
    setState(() {
      if (altura > 0) {
        _altura = "${altura.toStringAsFixed(2).replaceAll('.', ',')}m";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ConfigurationPage()));
            },
            child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(_username),
                ),
                accountName: Text(_username),
              accountEmail: Text(_altura),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConfigurationPage()));
            },
            child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children:  [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Configurações"),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
