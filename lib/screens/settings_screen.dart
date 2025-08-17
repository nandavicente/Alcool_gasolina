import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onThemeChange;
  const SettingsScreen({super.key, required this.onThemeChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Tema escuro"),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              onThemeChange();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre o App"),
            subtitle: const Text("Versão 1.0.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Álcool ou Gasolina",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.local_gas_station),
                children: [
                  const Text("App desenvolvido em Flutter para ajudar motoristas a escolher entre Álcool e Gasolina."),
                  const Text("Desenvolvido por Maria Fernanda "),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
