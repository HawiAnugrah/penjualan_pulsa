import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  final List<String> riwayatTransaksi;

  RiwayatScreen(this.riwayatTransaksi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Transaksi')),
      body: riwayatTransaksi.isEmpty
          ? Center(child: Text('Belum ada transaksi'))
          : ListView.builder(
        itemCount: riwayatTransaksi.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(riwayatTransaksi[index]),
          );
        },
      ),
    );
  }
}
