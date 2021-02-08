import 'package:simpen_simpen/core/models/model.dart';

class Simpenan extends Model {
  Simpenan({
    this.id,
    this.title,
    this.type,
    this.category,
    this.amount,
  });

  int id;
  String title;
  int type;
  String category;
  int amount;

  factory Simpenan.fromJson(Map<String, dynamic> json) => Simpenan(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "amount": amount == null ? null : amount,
      };
}
