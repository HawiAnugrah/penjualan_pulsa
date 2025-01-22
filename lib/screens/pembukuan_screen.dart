import 'package:flutter/material.dart';

class PembukuanScreen extends StatefulWidget {
  final double pemasukan; // Total pemasukan
  final double pengeluaran; // Total pengeluaran
  final List<String> riwayatIsiSaldo; // Referensi ke riwayat transaksi (langsung dari HomeService)

  PembukuanScreen({
    required this.pemasukan,
    required this.pengeluaran,
    required this.riwayatIsiSaldo,
  });

  @override
  _PembukuanScreenState createState() => _PembukuanScreenState();
}

class _PembukuanScreenState extends State<PembukuanScreen> {
  final TextEditingController _textController = TextEditingController();

  double get keuntungan => widget.pemasukan - widget.pengeluaran;

  // Fungsi untuk menambah riwayat baru secara manual
  void _addRiwayat(String isiSaldo) {
    setState(() {
      widget.riwayatIsiSaldo.add(isiSaldo); // Tambahkan ke sumber data
    });
    Navigator.of(context).pop(); // Tutup dialog
  }

  // Fungsi untuk mengedit riwayat
  void _editRiwayat(int index, String updatedSaldo) {
    setState(() {
      widget.riwayatIsiSaldo[index] = updatedSaldo; // Perbarui langsung di sumber data
    });
    Navigator.of(context).pop();
  }

  // Fungsi untuk menghapus riwayat
  void _deleteRiwayat(int index) {
    setState(() {
      widget.riwayatIsiSaldo.removeAt(index); // Hapus langsung di sumber data
    });
  }

  // Dialog untuk menambah atau mengedit riwayat
  void _showInputDialog({int? index}) {
    if (index != null) {
      _textController.text = widget.riwayatIsiSaldo[index];
    } else {
      _textController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Tambah Riwayat' : 'Edit Riwayat'),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: 'Masukkan detail isi saldo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (index == null) {
                _addRiwayat(_textController.text); // Tambah riwayat baru
              } else {
                _editRiwayat(index, _textController.text); // Edit riwayat
              }
            },
            child: Text(index == null ? 'Tambah' : 'Simpan'),
          ),
        ],
      ),
    );
  }

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
                subtitle: Text('Rp${widget.pemasukan.toStringAsFixed(0)}'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.trending_down, color: Colors.red),
                title: Text('Total Pengeluaran'),
                subtitle: Text('Rp${widget.pengeluaran.toStringAsFixed(0)}'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(
                  keuntungan >= 0 ? Icons.attach_money : Icons.money_off,
                  color: keuntungan >= 0 ? Colors.green : Colors.red,
                ),
                title: Text('Keuntungan'),
                subtitle: Text(
                  'Rp${keuntungan.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: keuntungan >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Isi Saldo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blue),
                  onPressed: () => _showInputDialog(), // Tombol Create
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.riwayatIsiSaldo.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                    title: Text(widget.riwayatIsiSaldo[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showInputDialog(index: index), // Tombol Edit
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteRiwayat(index), // Tombol Delete
                        ),
                      ],
                    ),
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
