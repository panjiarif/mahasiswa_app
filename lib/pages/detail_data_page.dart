// lib/pages/detail_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa_app/models/mahasiswa.dart';

class DetailPage extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailPage({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Data Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              // <-- Tambahkan Center untuk mengatur posisi ikon
              child: CircleAvatar(
                radius: 60, // Ukuran lingkaran
                child: Icon(
                  Icons.person,
                  size: 80,
                  color:
                      Colors.blueGrey, // Anda bisa atur warna sesuai keinginan
                ),
              ),
            ),
            const SizedBox(height: 24), // Beri jarak antara ikon dan data
            _buildDetailRow('NIM', mahasiswa.nim),
            _buildDetailRow('NIM', mahasiswa.nim),
            _buildDetailRow('Nama', mahasiswa.nama),
            _buildDetailRow('Jurusan', mahasiswa.jurusan),
            _buildDetailRow('Tanggal Lahir',
                DateFormat('dd MMMM yyyy').format(mahasiswa.tanggal_lahir)),
            _buildDetailRow('Jenis Kelamin', mahasiswa.jenis_kelamin),
            _buildDetailRow('Alamat', mahasiswa.alamat),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
