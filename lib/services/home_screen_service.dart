import 'package:flutter/material.dart';

class HomeService {
  double saldo = 100000.0;
  double penghasilan = 0.0;
  double totalPengeluaran = 0.0;
  List<String> riwayatTransaksi = [];

  void tambahSaldo(double jumlah, Function setState) {
    setState(() {
      saldo += jumlah;
      riwayatTransaksi.add('Isi saldo Rp$jumlah');
    });
  }

  void beliPulsa(double nominal, String provider, String nomorHP, BuildContext context, Function setState) {
    if (saldo >= nominal) {
      setState(() {
        saldo -= nominal;
        penghasilan += nominal + 2000;
        totalPengeluaran += nominal;
        riwayatTransaksi.add('Pembelian pulsa Rp$nominal untuk $nomorHP di $provider');
      });

      _showDialog(context, 'Pembelian Pulsa Berhasil', 'Pulsa Rp$nominal telah berhasil dikirim ke nomor $nomorHP.');
    } else {
      _showSnackbar(context, 'Saldo tidak mencukupi');
    }
  }

  void beliData(double nominal, String provider, String nomorHP, BuildContext context, Function setState) {
    if (saldo >= nominal) {
      setState(() {
        saldo -= nominal;
        penghasilan += nominal + 3000;
        totalPengeluaran += nominal;
        riwayatTransaksi.add('Pembelian data Rp$nominal untuk $nomorHP di $provider');
      });

      _showDialog(context, 'Pembelian Data Berhasil', 'Paket data Rp$nominal telah berhasil dikirim ke nomor $nomorHP.');
    } else {
      _showSnackbar(context, 'Saldo tidak mencukupi');
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

