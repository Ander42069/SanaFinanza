import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'add_transaction_screen.dart';

//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:fl_chart/fl_chart.dart';

//import 'package:flutter/material.dart';

void main() {
  runApp(MyFinanceApp());
}

class MyFinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanaFinanza',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FinanceHomePage(),
    );
  }
}

class FinanceHomePage extends StatefulWidget {
  @override
  _FinanceHomePageState createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  double totalIngresos = 1500.0;
  double totalGastos = 500.0;
  double totalBalance = 1000.0;
  int _selectedIndex = 0;
  //List<TransactionItem> transactions = [];
  List<TransactionItem> ingresos = [];
  List<TransactionItem> gastos = [];

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
              'Total: \$${_getTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla de detalles
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: _getTabText(),
                      transactions: _getCurrentList(),
                    ),
                  ),
                );
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
                    Padding(padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.attach_money, color: Colors.white),
                    ),
                    Text(
                     _getTabText(),
                     style: TextStyle(color: Colors.white),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: Text(
                        '\$${_getTotal().toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
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

  List<TransactionItem> _getCurrentList() {
  if (_getTabText() == 'Ingresos') {
    return ingresos;
  } else if (_getTabText() == 'Gastos') {
    return gastos;
  } else {
    // Manejar otras pestañas si es necesario
    return [];
  }
}


  /*void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      _navigateToDetailScreen('Ingresos', ingresos);
    } else if (_selectedIndex == 1) {
      _navigateToDetailScreen('Gastos', gastos);
    } else {
      // Si hay más pestañas, añadir lógica aquí
    }
  });
}*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  double _getTotal() {
    switch (_selectedIndex) {
      case 0:
        return totalIngresos;
      case 1:
        return totalGastos;
      case 2:
        return totalBalance;
      default:
        return 0.0;
    }
  }

  String _getTabText() {
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

  /*void _navigateToDetailScreen(String title, List<TransactionItem> transactions) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          title: title,
          transactions: transactions,
        ),
      ),
    );
  }*/
  
}


























/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Resumen Noviembre 2023'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Text('Ingresos'),
    Text('Gastos'),
    Text('Balance'),
  ];

  double dineroTotal = 1000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: charts.PieChart(
                _createSampleData(),
                animate: true,
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 60,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total \$0',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _widgetOptions,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 100),
      LinearSales(1, 75),
      LinearSales(2, 25),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}*/