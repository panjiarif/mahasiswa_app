// lib/pages/edit_data_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mahasiswa.dart';
import '../services/database_helper.dart';

class EditDataPage extends StatefulWidget {
  final Mahasiswa mahasiswa;
  const EditDataPage({super.key, required this.mahasiswa});

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nimController;
  late final TextEditingController _namaController;
  late final TextEditingController _jurusanController;
  late final TextEditingController _alamatController;
  late DateTime _selectedDate;
  late String _selectedJenisKelamin;
  final List<String> _jenisKelaminOptions = ['Laki-laki', 'Perempuan'];

  @override
  void initState() {
    super.initState();
    _nimController = TextEditingController(text: widget.mahasiswa.nim);
    _namaController = TextEditingController(text: widget.mahasiswa.nama);
    _jurusanController = TextEditingController(text: widget.mahasiswa.jurusan);
    _alamatController = TextEditingController(text: widget.mahasiswa.alamat);
    _selectedDate = widget.mahasiswa.tanggal_lahir;
    _selectedJenisKelamin = widget.mahasiswa.jenis_kelamin;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _updateData() async {
    if (_formKey.currentState!.validate()) {
      final updatedMahasiswa = Mahasiswa(
        id: widget.mahasiswa.id,
        nim: _nimController.text,
        nama: _namaController.text,
        jurusan: _jurusanController.text,
        tanggal_lahir: _selectedDate,
        jenis_kelamin: _selectedJenisKelamin,
        alamat: _alamatController.text,
      );
      await DatabaseHelper.instance.updateMahasiswa(updatedMahasiswa);
      Navigator.pop(context); // Kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Mahasiswa berhasil diubah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Data Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'NIM tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jurusanController,
                decoration: const InputDecoration(labelText: 'Jurusan', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Jurusan tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(text: DateFormat('dd MMMM yyyy').format(_selectedDate)),
                    decoration: const InputDecoration(labelText: 'Tanggal Lahir', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Tanggal lahir tidak boleh kosong';
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedJenisKelamin,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin', border: OutlineInputBorder()),
                items: _jenisKelaminOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJenisKelamin = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Alamat tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}