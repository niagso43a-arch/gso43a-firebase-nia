class Mahasiswa {
  final String? id;
  final String nim;
  final String nama;
  final String jurusan;
  final int semester;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.jurusan,
    required this.semester,
  });

  // Convert Mahasiswa to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'nim': nim,
      'nama': nama,
      'jurusan': jurusan,
      'semester': semester,
    };
  }

  // Create Mahasiswa from Firestore document
  factory Mahasiswa.fromMap(Map<String, dynamic> map, String id) {
    return Mahasiswa(
      id: id,
      nim: map['nim'] ?? '',
      nama: map['nama'] ?? '',
      jurusan: map['jurusan'] ?? '',
      semester: map['semester'] ?? 1,
    );
  }
}
