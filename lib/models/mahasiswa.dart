class Mahasiswa {
  int? id; // Tambahkan id untuk identifikasi di database
  final String nim;
  final String nama;
  final String jurusan;
  final DateTime tanggal_lahir;
  final String no_telp;
  final String email;
  final String jenis_kelamin;
  final String alamat;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.jurusan,
    required this.tanggal_lahir,
    required this.no_telp,
    required this.email,
    required this.jenis_kelamin,
    required this.alamat,
  });

  // Metode untuk konversi dari Map (dari database) ke objek Mahasiswa
  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nim: map['nim'],
      nama: map['nama'],
      jurusan: map['jurusan'],
      tanggal_lahir: DateTime.parse(map['tanggal_lahir']),
      no_telp: map['no_telp'],
      email: map['email'],
      jenis_kelamin: map['jenis_kelamin'],
      alamat: map['alamat'],
    );
  }

  // Metode untuk konversi dari objek Mahasiswa ke Map (untuk database)
  Map<String, dynamic> toMap() {
    return {
      'nim': nim,
      'nama': nama,
      'jurusan': jurusan,
      'tanggal_lahir': tanggal_lahir.toIso8601String(),
      'jenis_kelamin': jenis_kelamin,
      'no_telp': no_telp,
      'email': email,
      'alamat': alamat,
    };
  }
}
