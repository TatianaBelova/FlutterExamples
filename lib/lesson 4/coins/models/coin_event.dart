class CoinEventModel {
  String id;
  String date;
  String dateTo;
  String name;
  String description;
  bool isConference;
  String link;
  String proofImageLink;

  CoinEventModel(
      {this.id,
        this.date,
        this.dateTo,
        this.name,
        this.description,
        this.isConference,
        this.link,
        this.proofImageLink});

  CoinEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateTo = json['date_to'];
    name = json['name'];
    description = json['description'];
    isConference = json['is_conference'];
    link = json['link'];
    proofImageLink = json['proof_image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_to'] = this.dateTo;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_conference'] = this.isConference;
    data['link'] = this.link;
    data['proof_image_link'] = this.proofImageLink;
    return data;
  }
}