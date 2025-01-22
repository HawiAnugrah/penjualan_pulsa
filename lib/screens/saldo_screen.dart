import 'package:flutter/material.dart';

class SaldoScreen extends StatelessWidget {
  final Function(double) tambahSaldo;

  SaldoScreen(this.tambahSaldo);

  final TextEditingController _saldoController = TextEditingController();

  void _showPurchaseConfirmation(BuildContext context, double nominal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Isi Saldo Berhasil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 20),
            Text(
              'Saldo berhasil ditambahkan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
              title: Text('Nominal'),
              subtitle: Text('Rp${nominal.toStringAsFixed(0)}'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _isiSaldo(BuildContext context, double nominal) {
    if (nominal >= 10000) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Metode Pembayaran'),
          content: Text('Pilih metode pembayaran untuk isi saldo'),
          actions: [
            TextButton(
              onPressed: () {
                tambahSaldo(nominal);
                Navigator.pop(context); // Close payment method dialog
                _showPurchaseConfirmation(context, nominal);
              },
              child: Text('E-Wallet'),
            ),
            TextButton(
              onPressed: () {
                tambahSaldo(nominal);
                Navigator.pop(context); // Close payment method dialog
                _showPurchaseConfirmation(context, nominal);
              },
              child: Text('Bank Transfer'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nominal minimal adalah Rp10,000')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Saldo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _saldoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan nominal isi saldo (min Rp10,000)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? jumlah = double.tryParse(_saldoController.text);
                if (jumlah != null) {
                  _isiSaldo(context, jumlah);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Masukkan nominal yang valid')),
                  );
                }
              },
              child: Text('Isi Saldo'),
            ),
          ],
        ),
      ),
    );
  }
}
