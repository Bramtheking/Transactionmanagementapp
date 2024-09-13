import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For json decoding
import 'dart:io'; // For catching SocketException

class GetTransactionByIdActivity extends StatefulWidget {
  const GetTransactionByIdActivity({super.key});

  @override
  State<GetTransactionByIdActivity> createState() => _GetTransactionByIdActivityState();
}

class _GetTransactionByIdActivityState extends State<GetTransactionByIdActivity> {
  final TextEditingController _idController = TextEditingController();
  Map<String, dynamic>? _transactionData;
  String _errorMessage = '';

  Future<void> getTransactionById(String transactionId) async {
    try {
      final response = await http.get(
        Uri.parse('https://infra.devskills.app/api/transaction-management/transactions/$transactionId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _transactionData = jsonDecode(response.body); // Parse the JSON response
          _errorMessage = '';
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Transaction not found.';
          _transactionData = null;
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _errorMessage = 'Server error. Please try again later.';
          _transactionData = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch transaction. Error code: ${response.statusCode}';
          _transactionData = null;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _errorMessage = 'No Internet connection. Please check your connection and try again.';
        _transactionData = null;
      });
    } on http.ClientException catch (e) {
      setState(() {
        _errorMessage = 'Client error: ${e.message}';
        _transactionData = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: ${e.toString()}';
        _transactionData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Transaction by ID')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Enter Transaction ID'),
            ),
            ElevatedButton(
              onPressed: () {
                getTransactionById(_idController.text);
              },
              child: const Text('Fetch Transaction'),
            ),
            if (_errorMessage.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            if (_transactionData != null) 
              Card(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction ID: ${_transactionData!['transaction_id'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Account ID: ${_transactionData!['account_id'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Amount: \$${_transactionData!['amount'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Created At: ${_transactionData!['created_at'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
