import 'package:flutter/material.dart';
import '../models/quote.dart';

class QuoteDetailScreen extends StatelessWidget {
  final Quote quote;

  const QuoteDetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Citação')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.quote,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- ${quote.author}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(quote.context.isNotEmpty ? quote.context : 'Contexto não disponível.'),
          ],
        ),
      ),
    );
  }
}