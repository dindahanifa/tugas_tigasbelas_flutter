import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/dbhelper/dbhelper_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';

class PendataanResep extends StatefulWidget {
  final Resep? resep;

  PendataanResep({this.resep});

  @override
  _PendataanResepState createState() => _PendataanResepState();
}

class _PendataanResepState extends State<PendataanResep> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaResepController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController bahanBahanController = TextEditingController();
  final TextEditingController langkahLangkahController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.resep != null) {
      final resep = widget.resep!;
      namaResepController.text = resep.judul;
      gambarController.text = resep.gambarUrl;
      deskripsiController.text = resep.deskripsi;
      bahanBahanController.text = resep.bahan;
      langkahLangkahController.text = resep.langkah;
      kategoriController.text = resep.kategori;
    }
  }

  @override
  void dispose() {
    namaResepController.dispose();
    gambarController.dispose();
    deskripsiController.dispose();
    bahanBahanController.dispose();
    langkahLangkahController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    namaResepController.clear();
    gambarController.clear();
    deskripsiController.clear();
    bahanBahanController.clear();
    langkahLangkahController.clear();
    kategoriController.clear();
  }

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      final newResep = Resep(
        judul: namaResepController.text,
        gambarUrl: gambarController.text,
        deskripsi: deskripsiController.text,
        bahan: bahanBahanController.text,
        langkah: langkahLangkahController.text,
        kategori: kategoriController.text,
        isFavorit: '0',
      );

      if (widget.resep == null) {
        await DbhelperResep.insertResep(newResep);
        _showDialog("Berhasil", "Resep berhasil disimpan.");
        _resetForm();
      } else {
        final updatedResep = newResep.copyWith(id: widget.resep!.id);
        await DbhelperResep.updateResep(updatedResep);
        Navigator.pop(context, true);
      }
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resep == null ? "Tambah Resep" : "Edit Resep"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                    label: "Judul Resep", controller: namaResepController),
                _buildTextField(
                    label: "URL Gambar", controller: gambarController),
                _buildTextField(
                    label: "Deskripsi",
                    controller: deskripsiController,
                    maxLines: 3),
                _buildTextField(
                    label: "Bahan-bahan",
                    controller: bahanBahanController,
                    maxLines: 3),
                _buildTextField(
                    label: "Langkah-langkah",
                    controller: langkahLangkahController,
                    maxLines: 3),
                _buildTextField(label: "Kategori", controller: kategoriController),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: simpanData,
                  child: Text(widget.resep == null ? "Simpan" : "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
