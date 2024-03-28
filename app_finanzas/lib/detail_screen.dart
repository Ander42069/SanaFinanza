import 'package:flutter/material.dart';
import 'add_transaction_screen.dart';
import 'edit_transaction_screen.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final List<TransactionItem> transactions;

  DetailScreen({required this.title, required this.transactions});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navegar a la pantalla de agregar ingreso/gasto
              await Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context) => AddTransactionScreen(transactions: transactions),
                ),
              );
            }, 
          )
        ],
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de edición
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTransactionScreen(
                    transaction: transactions[index],
                    onEdit: (editedTransaction) {
                      // Actualizar la transaccion después de la edición
                      transactions[index] = editedTransaction;
                    },
                    onDelete: (deletedTransaction) {
                      // Eliminar la transacción de la lista
                      transactions.remove(deletedTransaction);
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transactions[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    transactions[index].type,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}