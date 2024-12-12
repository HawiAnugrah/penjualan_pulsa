import 'package:flutter/material.dart';
import 'saldo_screen.dart';
import 'pulsa/pulsa_screen.dart';
import 'riwayat_screen.dart';
import 'pembukuan_screen.dart'; // Import PembukuanScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double saldo = 10000.0;
  double penghasilan = 0.0; // Total income from pulsa sales
  double totalPengeluaran = 0.0; // Total expenses
  List<String> riwayatTransaksi = [];

  void tambahSaldo(double jumlah) {
    setState(() {
      saldo += jumlah;
      riwayatTransaksi.add('Isi saldo Rp$jumlah'); // Add recharge transaction
    });
  }

  void beliPulsa(double nominal, String provider, String nomorHP) {
    if (saldo >= nominal) {
      setState(() {
        saldo -= nominal; // Kurangi saldo dengan nominal pulsa
        penghasilan += 2000; // Tambahkan pemasukan default
        totalPengeluaran += nominal; // Tambahkan nominal pulsa ke total pengeluaran
        riwayatTransaksi.add('Pembelian pulsa Rp$nominal untuk $nomorHP di $provider');
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Pembelian Pulsa Berhasil'),
          content: Text('Pulsa Rp$nominal telah berhasil dikirim ke nomor $nomorHP.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saldo tidak mencukupi')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jual Pulsa'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Jual Pulsa',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: Text('Saldo'),
                subtitle: Text('Rp${saldo.toStringAsFixed(0)}'),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SaldoScreen(tambahSaldo)),
                    );
                  },
                  child: Text('Isi Saldo'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _menuButton(Icons.phone, 'Pulsa', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PulsaScreen(beliPulsa)),
                  );
                }),
                _menuButton(Icons.data_usage, 'Data', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Menu Data belum tersedia')),
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _menuButton(Icons.help, 'Bantuan', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Menu Bantuan belum tersedia')),
                  );
                }),
                _menuButton(Icons.history, 'Riwayat', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RiwayatScreen(riwayatTransaksi)),
                  );
                }),
                _menuButton(Icons.receipt, 'Pembukuan', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PembukuanScreen(
                        pemasukan: penghasilan, // Kirim total pemasukan
                        pengeluaran: totalPengeluaran, // Kirim total pengeluaran
                        riwayatIsiSaldo: riwayatTransaksi, // Kirim riwayat transaksi
                      ),
                    ),
                  );
                }),


              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(IconData icon, String label, Function onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
