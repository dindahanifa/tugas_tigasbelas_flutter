class Resep {
  final int? id;
  final String judul;
  final String gambarUrl;
  final String deskripsi;
  final String bahan;
  final String langkah;
  final String kategori;
  final String isFavorit;

  Resep({
    this.id,
    required this.judul,
    required this.gambarUrl,
    required this.deskripsi,
    required this.bahan,
    required this.langkah,
    required this.kategori,
    required this.isFavorit,
  });

  // Tambahkan ini agar bisa buat salinan dengan perubahan
  Resep copyWith({
    int? id,
    String? judul,
    String? gambarUrl,
    String? deskripsi,
    String? bahan,
    String? langkah,
    String? kategori,
    String? isFavorit,
  }) {
    return Resep(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      gambarUrl: gambarUrl ?? this.gambarUrl,
      deskripsi: deskripsi ?? this.deskripsi,
      bahan: bahan ?? this.bahan,
      langkah: langkah ?? this.langkah,
      kategori: kategori ?? this.kategori,
      isFavorit: isFavorit ?? this.isFavorit,
    );
  }

  // Konversi ke map untuk database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'gambar': gambarUrl,
      'deskripsi': deskripsi,
      'bahan': bahan,
      'langkah': langkah,
      'kategori': kategori,
      'isFavorit': isFavorit,
    };
  }

  // Buat dari map (saat ambil dari DB)
  factory Resep.fromMap(Map<String, dynamic> map) {
    return Resep(
      id: map['id'],
      judul: map['judul'],
      gambarUrl: map['gambar'],
      deskripsi: map['deskripsi'],
      bahan: map['bahan'],
      langkah: map['langkah'],
      kategori: map['kategori'],
      isFavorit: map['isFavorit'],
    );
  }
}
