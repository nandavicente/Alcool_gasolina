import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static const String _key = "historico";

  static Future<void> salvarResultado(
      double alcool, double gasolina, String recomendacao) async {
    final prefs = await SharedPreferences.getInstance();

    final novoItem = {
      "alcool": alcool.toStringAsFixed(2),
      "gasolina": gasolina.toStringAsFixed(2),
      "recomendacao": recomendacao,
      "data": DateTime.now().toString(),
    };

    final historico = prefs.getStringList(_key) ?? [];
    historico.add(jsonEncode(novoItem));

    await prefs.setStringList(_key, historico);
  }

  static Future<List<Map<String, dynamic>>> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    final historico = prefs.getStringList(_key) ?? [];

    return historico
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList()
        .reversed
        .toList(); // ordem mais recente primeiro
  }
}
