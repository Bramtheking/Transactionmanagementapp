import 'package:flutter/material.dart';
import 'package:myapp/your_app/get_transactions_activity.dart';
import 'package:myapp/your_app/get_transaction_by_id_activity.dart';
import 'package:myapp/your_app/create_transaction_activity.dart';
import 'package:myapp/your_app/get_account_by_id_activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.amber.shade50, // Goldish background
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Management'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavigationCard(
                context,
                'Get Transactions',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetTransactionsActivity()),
                  );
                },
              ),
              _buildNavigationCard(
                context,
                'Get Transaction by ID',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetTransactionByIdActivity()),
                  );
                },
              ),
              _buildNavigationCard(
                context,
                'Create Transaction',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateTransactionActivity()),
                  );
                },
              ),
              _buildNavigationCard(
                context,
                'Get Account by ID',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetAccountByIdActivity()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      elevation: 8,
      color: Colors.deepPurple.shade100,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
