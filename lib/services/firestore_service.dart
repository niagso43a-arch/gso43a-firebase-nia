import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mahasiswa.dart';

class FirestoreService {
  final CollectionReference _mahasiswaCollection =
      FirebaseFirestore.instance.collection('mahasiswa');

  // Create - Tambah data mahasiswa
  Future<void> addMahasiswa(Mahasiswa mahasiswa) async {
    try {
      await _mahasiswaCollection.add(mahasiswa.toMap());
    } catch (e) {
      throw 'Gagal menambahkan data: $e';
    }
  }

  // Read - Get all mahasiswa as stream
  Stream<List<Mahasiswa>> getMahasiswaStream() {
    return _mahasiswaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Mahasiswa.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Read - Search mahasiswa
  Stream<List<Mahasiswa>> searchMahasiswa(String query) {
    if (query.isEmpty) {
      return getMahasiswaStream();
    }
    
    return _mahasiswaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Mahasiswa.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).where((mahasiswa) {
        return mahasiswa.nim.toLowerCase().contains(query.toLowerCase()) ||
            mahasiswa.nama.toLowerCase().contains(query.toLowerCase()) ||
            mahasiswa.jurusan.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Update - Ubah data mahasiswa
  Future<void> updateMahasiswa(String id, Mahasiswa mahasiswa) async {
    try {
      await _mahasiswaCollection.doc(id).update(mahasiswa.toMap());
    } catch (e) {
      throw 'Gagal mengubah data: $e';
    }
  }

  // Delete - Hapus data mahasiswa
  Future<void> deleteMahasiswa(String id) async {
    try {
      await _mahasiswaCollection.doc(id).delete();
    } catch (e) {
      throw 'Gagal menghapus data: $e';
    }
  }

  // Get total count
  Future<int> getTotalMahasiswa() async {
    try {
      final snapshot = await _mahasiswaCollection.get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }
}
