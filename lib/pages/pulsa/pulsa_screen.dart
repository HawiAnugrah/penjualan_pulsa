import 'package:flutter/material.dart';
import 'provider.dart';
import 'denomination.dart';

class PulsaScreen extends StatelessWidget {
  final Function(double, String, String) beliPulsa;

  PulsaScreen(this.beliPulsa, {super.key});

  final TextEditingController _nomorHpController = TextEditingController();

  static final List<Provider> providers = [
    Provider('Telkomsel', 'assets/images/telkomsel.png'),
    Provider('XL', 'assets/images/xl.png'),
    Provider('Axis', 'assets/images/axis.png'),
    Provider('IM3', 'assets/images/im3.png'),
    Provider('Smartfren', 'assets/images/smartfren.png'),
  ];

  static final List<Denomination> nominal = [
    Denomination(5000.0, 'Rp5,000'),
    Denomination(10000.0, 'Rp10,000'),
    Denomination(20000.0, 'Rp20,000'),
    Denomination(50000.0, 'Rp50,000'),
    Denomination(100000.0, 'Rp100,000'),
  ];

  void _pilihNominal(BuildContext context, Provider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Nominal Pulsa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: nominal
              .map((deno) => ListTile(
                    title: Text(deno.label),
                    onTap: () => _inputNomorHP(context, provider, deno.amount),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _inputNomorHP(BuildContext context, Provider provider, double nominal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Masukkan Nomor HP'),
        content: TextField(
          controller: _nomorHpController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: 'Nomor HP'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String nomorHp = _nomorHpController.text;
              if (nomorHp.isNotEmpty) {
                beliPulsa(nominal, provider.name, nomorHp);
                Navigator.pop(context); // Close dialog
                _showPurchaseConfirmation(context, nominal, nomorHp);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nomor HP tidak boleh kosong')),
                );
              }
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _showPurchaseConfirmation(BuildContext context, double nominal, String nomorHp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pembelian Berhasil'),
        content: Text(
          'Pulsa Rp${nominal.toStringAsFixed(0)} untuk nomor $nomorHp berhasil dibeli!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close confirmation popup
              Navigator.pop(context); // Back to HomeScreen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembelian Pulsa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: providers
              .map((provider) => ListTile(
                    leading: Image.asset(provider.imageAssetPath, width: 40, height: 40),
                    title: Text(provider.name),
                    onTap: () => _pilihNominal(context, provider),
                  ))
              .toList(),
        ),
      ),
    );
  }
}