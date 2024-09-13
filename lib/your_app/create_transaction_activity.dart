import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // For catching SocketException

class CreateTransactionActivity extends StatefulWidget {
  const CreateTransactionActivity({super.key});

  @override
  State<CreateTransactionActivity> createState() => _CreateTransactionActivityState();
}

class _CreateTransactionActivityState extends State<CreateTransactionActivity> {
  final TextEditingController _accountIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _transactionResult = '';

  Future<void> createTransaction(String accountId, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('https://infra.devskills.app/api/transaction-management/transactions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'account_id': accountId, 'amount': amount}),
      );

      if (response.statusCode == 201) {
        setState(() {
          _transactionResult = 'Transaction created successfully';
        });
      } else if (response.statusCode == 400) {
        setState(() {
          _transactionResult = 'Bad Request: Invalid input.';
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _transactionResult = 'Server error. Please try again later.';
        });
      } else {
        setState(() {
          _transactionResult = 'Failed to create transaction. Error code: ${response.statusCode}';
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _transactionResult = 'No Internet connection. Please check your connection and try again.';
      });
    } on http.ClientException catch (e) {
      setState(() {
        _transactionResult = 'Client error: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _transactionResult = 'An unexpected error occurred: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _accountIdController,
              decoration: const InputDecoration(labelText: 'Enter Account ID'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Amount'),
            ),
            ElevatedButton(
              onPressed: () {
                createTransaction(_accountIdController.text, double.parse(_amountController.text));
              },
              child: const Text('Create Transaction'),
            ),
            Text('Transaction Result: $_transactionResult'),
          ],
        ),
      ),
    );
  }
}
