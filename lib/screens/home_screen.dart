import 'package:flutter/material.dart';

import '../utils/storage_helper.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChange;
  const HomeScreen({super.key, required this.onThemeChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _alcoolController = TextEditingController();
  final _gasolinaController = TextEditingController();
  String? _resultado;

  void _calcular() async {
    final alcoolText = _alcoolController.text;
    final gasolinaText = _gasolinaController.text;

    if (alcoolText.isEmpty || gasolinaText.isEmpty) {
      _mostrarMensagem("Por favor, preencha ambos os campos.");
      return;
    }

    final alcool = double.tryParse(alcoolText);
    final gasolina = double.tryParse(gasolinaText);

    if (alcool == null || gasolina == null || alcool <= 0 || gasolina <= 0) {
      _mostrarMensagem("Insira valores válidos maiores que 0.");
      return;
    }

    final proporcao = alcool / gasolina;
    String recomendacao = proporcao <= 0.7
        ? "Compensa abastecer com Álcool"
        : "Compensa abastecer com Gasolina";

    setState(() {
      _resultado =
      "Álcool: R\$ ${alcool.toStringAsFixed(2)}\nGasolina: R\$ ${gasolina.toStringAsFixed(2)}\n\n$recomendacao";
    });

    // salvar no histórico
    await StorageHelper.salvarResultado(
      alcool,
      gasolina,
      recomendacao,
    );
  }

  void _mostrarMensagem(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool ou Gasolina"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          ),
          const Tooltip(
            message:
            "Se o preço do álcool for até 70% do preço da gasolina, compensa abastecer com álcool.",
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _alcoolController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço do Álcool",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _gasolinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço da Gasolina",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcular,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            if (_resultado != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _resultado!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
