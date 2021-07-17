class UserInfo {
  String id;
  String userEmail;
  String userName;
  String userImage;
  String status;

  UserInfo({
    this.id,
    this.userEmail,
    this.userName,
    this.userImage,
    this.status,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userImage: json['image'],
      status: json['status'],
    );
  }
}
