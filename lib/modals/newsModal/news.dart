class NewsData {
  String id;
  String headLine;
  String image;
  String des;
  String approval;

  NewsData({this.id, this.headLine, this.image, this.des, this.approval});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json['id'],
      headLine: json['headLine'],
      image: json['image'],
      des: json['des'],
      approval: json['approval'],
    );
  }
}
