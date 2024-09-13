import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert'; // For json decoding
import 'package:http/http.dart' as http; // For http requests
import 'dart:io'; // For catching socket exceptions

class Transaction {
  final String transactionId;
  final String accountId;
  final double amount;
  final String createdAt;

  Transaction({
    required this.transactionId,
    required this.accountId,
    required this.amount,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transaction_id'],
      accountId: json['account_id'],
      amount: json['amount'].toDouble(),
      createdAt: json['created_at'],
    );
  }
}

class GetTransactionsActivity extends StatefulWidget {
  const GetTransactionsActivity({super.key});

  @override
  _GetTransactionsActivityState createState() =>
      _GetTransactionsActivityState();
}

class _GetTransactionsActivityState extends State<GetTransactionsActivity> {
  late Future<List<Transaction>> futureTransactions;

  @override
  void initState() {
    super.initState();
    futureTransactions = fetchTransactions();
  }

  Future<List<Transaction>> fetchTransactions() async {
    try {
      final response = await http
          .get(
            Uri.parse(
                'https://infra.devskills.app/api/transaction-management/transactions'),
          )
          .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        showErrorToast(
            'Server error: ${response.statusCode}. Please try again later.');
        throw Exception('Failed to load transactions.');
      }
    } on SocketException catch (_) {
      showErrorToast('No Internet connection. Please check your connection.');
      return [];
    } on TimeoutException catch (_) {
      showErrorToast('Request timed out. Please try again later.');
      return [];
    } catch (e) {
      // Handle any other type of error (parsing, etc.)
      showErrorToast('An unexpected error occurred: ${e.toString()}');
      return [];
    }
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      body: FutureBuilder<List<Transaction>>(
        future: futureTransactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display fallback message if the error isn't caught earlier
            return const Center(child: Text("Failed to load transactions."));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text("No transactions found."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Transaction ID: ${transaction.transactionId}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account ID: ${transaction.accountId}"),
                        Text("Amount: \$${transaction.amount}"),
                        Text("Created At: ${transaction.createdAt}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
