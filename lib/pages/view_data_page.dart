import 'package:flutter/material.dart';

import '../models/mahasiswa.dart';
import '../services/database_helper.dart';
import 'detail_data_page.dart';
import 'edit_data_page.dart';

class ViewDataPage extends StatefulWidget {
  const ViewDataPage({super.key});

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  late Future<List<Mahasiswa>> _mahasiswaList;

  @override
  void initState() {
    super.initState();
    _refreshMahasiswaList();
  }

  Future<void> _refreshMahasiswaList() async {
    setState(() {
      _mahasiswaList = DatabaseHelper.instance.getMahasiswaList();
    });
  }

  void _showActionDialog(Mahasiswa mahasiswa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilihan Aksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Detail Data'),
              onTap: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(mahasiswa: mahasiswa),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Ubah Data'),
              onTap: () async {
                Navigator.pop(context); // Tutup dialog
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDataPage(mahasiswa: mahasiswa),
                  ),
                );
                _refreshMahasiswaList(); // Muat ulang data setelah mengedit
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Hapus Data'),
              onTap: () {
                Navigator.pop(context); // Tutup dialog
                _showDeleteConfirmationDialog(mahasiswa.id!);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.deleteMahasiswa(id);
              Navigator.pop(context); // Tutup dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dihapus!')),
              );
              _refreshMahasiswaList(); // Muat ulang data setelah menghapus
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mahasiswa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshMahasiswaList,
          ),
        ],
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Mahasiswa>>(
        future: _mahasiswaList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data mahasiswa.'));
          } else {
            final mahasiswaList = snapshot.data!;
            return ListView.builder(
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                final mahasiswa = mahasiswaList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(mahasiswa.nama),
                    subtitle: Text(mahasiswa.nim),
                    onTap: () => _showActionDialog(mahasiswa),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
