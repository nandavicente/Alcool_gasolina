class FuelCalculator {
  /// Regra: Se o preço do álcool for até 70% do preço da gasolina,
  /// compensa abastecer com Álcool. Caso contrário, Gasolina.
  static String calcularMelhorCombustivel(double alcool, double gasolina) {
    if (alcool / gasolina <= 0.7) {
      return "Melhor abastecer com Álcool 🚗💨";
    } else {
      return "Melhor abastecer com Gasolina ⛽";
    }
  }
}