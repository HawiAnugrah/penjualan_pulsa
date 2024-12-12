import 'package:flutter/material.dart';

class SaldoScreen extends StatelessWidget {
  final Function(double) tambahSaldo;
  SaldoScreen(this.tambahSaldo);

  final TextEditingController _saldoController = TextEditingController();

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
                Navigator.pop(context);
                Navigator.pop(context);
                // Popup konfirmasi isi saldo berhasil
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Isi Saldo Berhasil'),
                    content: Text('Saldo Rp$nominal telah berhasil ditambahkan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('E-Wallet'),
            ),
            TextButton(
              onPressed: () {
                tambahSaldo(nominal);
                Navigator.pop(context);
                Navigator.pop(context);
                // Popup konfirmasi isi saldo berhasil
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Isi Saldo Berhasil'),
                    content: Text('Saldo Rp$nominal telah berhasil ditambahkan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
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
      appBar: AppBar(title: Text('Isi Saldo')),
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
