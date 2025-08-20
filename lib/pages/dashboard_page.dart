import 'package:flutter/material.dart';

import 'info_page.dart';
import 'input_data_page.dart';
import 'view_data_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Menu "Lihat Data"
          Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                // Navigasi ke halaman Lihat Data
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ViewDataPage()),
                );
              },
              leading: const Icon(Icons.list_alt,
                  color: Colors.blue), // Ikon di kiri
              title: const Text('Lihat Data'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 16), // Ikon di kanan
            ),
          ),
          const SizedBox(height: 16),

          // Menu "Input Data"
          Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                // Navigasi ke halaman Input Data
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const InputDataPage()),
                );
              },
              leading: const Icon(Icons.add_box_outlined, color: Colors.green),
              title: const Text('Input Data'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 16),
            ),
          ),
          const SizedBox(height: 16),

          // Menu "Informasi"
          Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                // Navigasi ke halaman Informasi
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InfoPage()),
                );
              },
              leading: const Icon(Icons.info_outline, color: Colors.orange),
              title: const Text('Informasi'),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
