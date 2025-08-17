import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> historico = [];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      historico = prefs.getStringList("historico") ?? [];
    });
  }

  Future<void> limparHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("historico");
    setState(() {
      historico.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Cálculos"),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: limparHistorico,
          ),
        ],
      ),
      body: historico.isEmpty
          ? const Center(child: Text("Nenhum cálculo salvo ainda."))
          : ListView.builder(
        itemCount: historico.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: Text(historico[index]),
          );
        },
      ),
    );
  }
}
