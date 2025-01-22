import 'package:flutter/material.dart';
import '../models/faq_model.dart';

class BantuanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil daftar FAQ dari model
    final faqList = FAQModel.getFAQList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                faq.question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(faq.answer),
              ),
            ),
          );
        },
      ),
    );
  }
}
