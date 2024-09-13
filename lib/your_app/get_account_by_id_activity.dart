import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON response
import 'dart:io'; // For catching SocketException

class GetAccountByIdActivity extends StatefulWidget {
  const GetAccountByIdActivity({super.key});

  @override
  State<GetAccountByIdActivity> createState() => _GetAccountByIdActivityState();
}

class _GetAccountByIdActivityState extends State<GetAccountByIdActivity> {
  final TextEditingController _accountIdController = TextEditingController();
  Map<String, dynamic>? _accountData;
  String _errorMessage = '';

  Future<void> getAccountById(String accountId) async {
    try {
      final response = await http.get(
        Uri.parse('https://infra.devskills.app/api/transaction-management/accounts/$accountId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _accountData = jsonDecode(response.body); // Parsing the response to a Map
          _errorMessage = '';
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Account not found.';
          _accountData = null;
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _errorMessage = 'Server error. Please try again later.';
          _accountData = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch account. Error code: ${response.statusCode}';
          _accountData = null;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _errorMessage = 'No Internet connection. Please check your connection and try again.';
        _accountData = null;
      });
    } on http.ClientException catch (e) {
      setState(() {
        _errorMessage = 'Client error: ${e.message}';
        _accountData = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: ${e.toString()}';
        _accountData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Account by ID')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _accountIdController,
              decoration: const InputDecoration(labelText: 'Enter Account ID'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                getAccountById(_accountIdController.text);
              },
              child: const Text('Fetch Account'),
            ),
            const SizedBox(height: 16),
            _errorMessage.isNotEmpty
                ? Text(_errorMessage, style: const TextStyle(color: Colors.red))
                : _accountData != null
                    ? Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Details',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 8),
                              Text('Account ID: ${_accountData!['account_id']}',
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Text('Balance: \$${_accountData!['balance']}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
