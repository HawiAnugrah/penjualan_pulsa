import 'package:flutter/material.dart';

class PembukuanScreen extends StatelessWidget {
  final double pemasukan; // Total pemasukan
  final double pengeluaran; // Total pengeluaran
  final List<String> riwayatIsiSaldo; // Riwayat isi saldo

  PembukuanScreen({
    required this.pemasukan,
    required this.pengeluaran,
    required this.riwayatIsiSaldo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembukuan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekapitulasi Keuangan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.trending_up, color: Colors.green),
                title: Text('Total Pemasukan'),
                subtitle: Text('Rp${pemasukan.toStringAsFixed(0)}'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.trending_down, color: Colors.red),
                title: Text('Total Pengeluaran'),
                subtitle: Text('Rp${pengeluaran.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Riwayat Isi Saldo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: riwayatIsiSaldo.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                    title: Text(riwayatIsiSaldo[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
