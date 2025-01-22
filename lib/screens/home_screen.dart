import 'package:flutter/material.dart';
import '../services/home_screen_service.dart';
import '../screens/saldo_screen.dart';
import '../screens/pulsa_screen.dart';
import '../screens/data_screen.dart';
import '../screens/riwayat_screen.dart';
import '../screens/pembukuan_screen.dart';
import '../screens/bantuan_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeService _homeService = HomeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Aplikasi Penjualan Pulsa & Data',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: Text('Saldo'),
                subtitle: Text('Rp${_homeService.saldo.toStringAsFixed(0)}'),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SaldoScreen((jumlah) {
                        _homeService.tambahSaldo(jumlah, setState);
                      })),
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
                    MaterialPageRoute(builder: (_) => PulsaScreen((nominal, provider, nomorHP) {
                      _homeService.beliPulsa(nominal, provider, nomorHP, context, setState);
                    })),
                  );
                }),
                _menuButton(Icons.data_usage, 'Data', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DataScreen((nominal, provider, nomorHP) {
                      _homeService.beliData(nominal, provider, nomorHP, context, setState);
                    })),
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _menuButton(Icons.help, 'Bantuan', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BantuanScreen()));
                }),
                _menuButton(Icons.history, 'Riwayat', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RiwayatScreen(_homeService.riwayatTransaksi)));
                }),
                _menuButton(Icons.receipt, 'Pembukuan', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PembukuanScreen(
                        pemasukan: _homeService.penghasilan,
                        pengeluaran: _homeService.totalPengeluaran,
                        riwayatIsiSaldo: _homeService.riwayatTransaksi,
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
