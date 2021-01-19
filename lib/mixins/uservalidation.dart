class Validation {
  String validateName(String value) {
    if (value.isEmpty) {
      return 'Nama Lengkap Harus Diisi';
    }

    if (value.length < 3 || value.length > 100) {
      return 'Panjang Karakter Min 3 Max 100';
    }
    return null;
  }

  String notelpName(String value) {
    if (value.isEmpty) {
      return 'No. Telepon Harus Diisi';
    }

    if (value.length < 3 || value.length > 100) {
      return 'No. Telepon Min 3 Max 20';
    }
    return null;
  }
}
