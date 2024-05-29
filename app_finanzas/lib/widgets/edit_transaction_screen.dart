import 'package:flutter/material.dart';
import 'package:app_finanzas/widgets/add_transaction_screen.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionItem transaction;
  final Function(TransactionItem) onEdit;
  final Function(TransactionItem) onDelete;
  final Function(TransactionItem) onEditTransaction;

  const EditTransactionScreen({super.key, 
    required this.transaction, 
    required this.onEdit, 
    required this.onDelete, 
    required this.onEditTransaction
    });

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.transaction.name);
    typeController = TextEditingController(text: widget.transaction.type);
    amountController = TextEditingController(text: widget.transaction.amount.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Ingreso/Gasto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
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
                // Lógica para guardar la edición
                final editedTransaction = TransactionItem(
                  id: widget.transaction.id,
                  name: nameController.text,
                  type: typeController.text,
                  amount: double.parse(amountController.text),
                );

                // Notificar a la pantalla anterior sobre la edición
                widget.onEdit(editedTransaction);

                // Aplicar las ediciones en DetailScreen
                widget.onEditTransaction(editedTransaction);

                // Cerrar la pantalla de edición
                Navigator.pop(context, editedTransaction);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }


Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar Transacción'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Estás seguro de que deseas eliminar esta transacción?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              // Lógica para eliminar la transacción
              widget.onDelete(widget.transaction);
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

}