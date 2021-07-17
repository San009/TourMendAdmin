class AdminInfo {
  String adminEmail;
  String adminName;
  String adminImage;
  String statusCode;

  AdminInfo({
    this.adminEmail,
    this.adminName,
    this.adminImage,
    this.statusCode,
  });

  factory AdminInfo.fromJson(Map<String, dynamic> json) {
    return AdminInfo(
      adminName: json['adminName'],
      adminEmail: json['adminEmail'],
      adminImage: json['image'],
      statusCode: json['statusCode'],
    );
  }
}
