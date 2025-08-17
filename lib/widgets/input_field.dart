import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.local_gas_station),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Preencha o valor do $label";
        }
        final double? parsed = double.tryParse(value);
        if (parsed == null || parsed <= 0) {
          return "Digite um valor válido maior que 0";
        }
        return null;
      },
    );
  }
}
