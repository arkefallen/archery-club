import 'package:cloud_firestore/cloud_firestore.dart';

class Members {
  String? id;
  String? code;
  String? username;
  String? nama;
  String? nomorHp;
  String? email;
  String? alamat;
  Timestamp? tanggalLahir;
  Timestamp? tanggalBergabung;
  String? jenisKelamin;
  String? pekerjaan;
  int? totalLatihan;
  String? kategori;
  String? fotoProfilUrl;
  String? password;
  String? roles;
  
  Members({
    this.id = '',
    this.code = '',
    this.username = '',
    this.nama = '',
    this.nomorHp = '',
    this.email = '',
    this.alamat = '',
    this.tanggalLahir,
    this.tanggalBergabung,
    this.jenisKelamin = '',
    this.pekerjaan = '',
    this.totalLatihan = 0,
    this.kategori = '',
    this.fotoProfilUrl = '',
    this.password = '',
    this.roles = '',
  });
}