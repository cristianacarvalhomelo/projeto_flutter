import 'package:flutter/material.dart';
import '../models/book.dart';

class bookDetailScreen extends StatelessWidget {
  final Book book;

  bookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.coverId.isNotEmpty)
              Center(
                child: Image.network(book.coverUrl, width: 100, height: 150),
              ),
            const SizedBox(height: 16.0),
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Autor: ${book.authorName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
