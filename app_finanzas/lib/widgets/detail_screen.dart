import 'package:flutter/material.dart';
import 'package:app_finanzas/widgets/add_transaction_screen.dart';
import 'package:app_finanzas/widgets/edit_transaction_screen.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final List<TransactionItem> transactions;
  final int selectedIndex;

  const DetailScreen({super.key, 
    required this.title, 
    required this.transactions, 
    required this.selectedIndex
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();

}

class _DetailScreenState extends State<DetailScreen> {
  late double _totalAmount;

  /*@override
  void initState() {
    super.initState();
    // Calcular el total inicial de las transacciones al iniciar la pantalla de detalles
    _totalAmount = _calculateTotalAmount();
  }*/

  // Maneja la edición de una transacción
  void editTransaction(TransactionItem editedTransaction) {
    setState(() {
      // Encuentra y reemplaza la transacción editada en la lista
      final index = widget.transactions.indexWhere((transaction) => transaction.id == editedTransaction.id);
      if (index != -1) {
        widget.transactions[index] = editedTransaction;
      }
    });
  }

  // Maneja la eliminación de una transacción
  void deleteTransaction(TransactionItem deletedTransaction) {
  setState(() {
    // Elimina la transacción de la lista
    widget.transactions.remove(deletedTransaction);
  });
}

/*double _calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var transaction in widget.transactions) {
      totalAmount += transaction.amount;
    }
    return totalAmount;
  }*/

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navegar a la pantalla de agregar ingreso/gasto
              final newTransaction = await Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context) => AddTransactionScreen(transactions: widget.transactions),
                ),
              );
              if (newTransaction != null) {
                // Agregar la nueva transacción a la lista
                widget.transactions.add(newTransaction);

                // Calcular el nuevo total de transacciones
                //final total = _calculateTotalAmount();

                // Actualizar la pantalla
                setState(() {
                  // Actualizar el total en la página de detalles
                //_totalAmount = total;
                });
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.transactions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de edición
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTransactionScreen(
                    transaction: widget.transactions[index],
                    onEdit: (editedTransaction) {
                      // Actualizar la transaccion después de la edición
                      widget.transactions[index] = editedTransaction;
                    },
                    onDelete: (deletedTransaction) {
                      // Eliminar la transacción de la lista
                      widget.transactions.remove(deletedTransaction);
                      //Llamar a la función para actualiar el estado
                      deleteTransaction(deletedTransaction);
                    },
                    onEditTransaction: editTransaction,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.transactions[index].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    widget.transactions[index].type,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '\$${widget.transactions[index].amount.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
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