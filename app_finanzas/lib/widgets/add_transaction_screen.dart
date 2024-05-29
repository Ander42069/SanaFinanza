import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<TransactionItem> transactions;

  AddTransactionScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Ingreso/Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                const uuid = Uuid();
                final newTransaction = TransactionItem(
                  id: uuid.v4(), //Genera un identificador único
                  name: nameController.text,
                  type: typeController.text,
                  amount: double.parse(amountController.text),
                );

                // Agregar el nuevo ingreso/gasto a la lista
                //transactions.add(newTransaction);
                
                // Cerrar la pantalla de agregar ingreso/gasto y retornar la nueva transacción
                Navigator.pop(context, newTransaction);
              }, 
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionItem {
  final String id;
  final String name;
  final String type;
  final double amount;

  TransactionItem({required this.id, required this.name, required this.type, required this.amount});
}