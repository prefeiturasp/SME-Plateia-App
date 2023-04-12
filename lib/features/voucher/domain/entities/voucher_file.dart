class VoucherFile {
  final String voucher;

  VoucherFile({
    required this.voucher,
  });

  factory VoucherFile.fromJson(Map<String, dynamic> json) {
    return VoucherFile(
      voucher: json['voucher'],
    );
  }
}
