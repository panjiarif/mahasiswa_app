// lib/pages/info_page.dart

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Aplikasi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.info_outline,
                size: 80,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Aplikasi Data Mahasiswa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Versi: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Pengembang: Panji Arif Jafarudin',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Deskripsi Aplikasi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi ini dibuat sebagai portofolio untuk mengelola data mahasiswa secara lokal. '
              'Fitur yang tersedia meliputi input data, menampilkan data, mengubah data, dan menghapus data mahasiswa.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}