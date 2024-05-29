import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_finanzas/widgets/detail_screen.dart';
import 'package:app_finanzas/widgets/add_transaction_screen.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://vmnlgvsqcxbkgekyecfv.supabase.co',
    anonKey: 
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtbmxndnNxY3hia2dla3llY2Z2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU5MTI2NDAsImV4cCI6MjAxMTQ4ODY0MH0.Fyq5ue1eX0RTxnjH0EdZz3fI8mtDfzgUn5mt_qGCb7Q',
  );
  runApp(const MyFinanceApp());
}

final supabase = Supabase.instance.client;

/*void main() {
  runApp(MyFinanceApp());
}*/

class MyFinanceApp extends StatelessWidget {
  const MyFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanaFinanza',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FinanceHomePage(),
    );
  }
}

class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({super.key});

  @override
  _FinanceHomePageState createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  late double totalIngresos;
  late double totalGastos;
  late double totalBalance;
  int _selectedIndex = 0;
  List<TransactionItem> ingresos = [];
  List<TransactionItem> gastos = [];

  @override
  void initState() {
    super.initState();
    _updateTotals();
  }

void _updateTotals() {
    totalIngresos = _calculateTotal(ingresos);
    totalGastos = _calculateTotal(gastos);
    totalBalance = totalIngresos - totalGastos;
  }

void _updateBalance() {
  setState(() {
    totalBalance = totalIngresos - totalGastos;
  });
}

double _getTotal() {
  return _calculateTotal(_getCurrentList());
}

 // Función para calcular el total de las transacciones
double _calculateTotal(List<TransactionItem> transactions) {
  double total = 0.0;
  for (var transaction in transactions) {
    total += transaction.amount;
  }
  return total;
}

// Obtener la lista actual basada en la pestaña seleccionada
  List<TransactionItem> _getCurrentList() {
  if (_getTitle() == 'Ingresos') {
    return ingresos;
  } else if (_getTitle() == 'Gastos') {
    return gastos;
  } else {
    // Manejar otras pestañas si es necesario
    return [];
    }
  }

// Obtener el título de la pestaña seleccionada
  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Ingresos';
      case 1:
        return 'Gastos';
      case 2:
        return 'Balance';
      default:
        return '';
    }
  }

void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        _updateTotals(); // Recalcula el balance cuando se selecciona la pestaña de balance
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _getTitle() == 'Balance'
                  ? 'Balance: \$${totalBalance.toStringAsFixed(2)}'
                  : 'Total: \$${_getTotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // Abrir pantalla de detalles
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: _getTitle(),
                      transactions: _getCurrentList(),
                      selectedIndex: _selectedIndex,
                    ),
                  ),
                );
                setState(() {
                  
                });
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.attach_money, color: Colors.white),
                    ),
                    Text(
                     _getTitle(),
                     style: const TextStyle(color: Colors.white),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: Text(
                        '\$${_getTotal().toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Ingresos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Balance',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}