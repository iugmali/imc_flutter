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
  late String _username ;
  late String _altura;

  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  _carregarDados() async {
    _username = await storage.getUsername();
    double altura = await storage.getAltura();
    _altura = altura.toString().replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConfigurationPage()));
            },
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.orange),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://branditechture.agency/brand-logos/wp-content/uploads/wpdm-cache/imperial-machine-company-imc-logo-vector-900x0.png"),
                ),
                accountName: Text(_username),
                accountEmail: Text(_altura)
            ),
          ),
        ],
      ),
    );
  }
}
