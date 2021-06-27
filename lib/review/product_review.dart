import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductReview {
  ProductReview(
      {this.rating, this.content, this.uid, this.dateTime, this.productId});
  final int rating;
  final String content, uid, productId;
  final DateTime dateTime;

  factory ProductReview.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}

ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) {
  return ProductReview(
      rating: json['rating'],
      content: json['content'],
      uid: json['uid'],
      dateTime: json['dateTime'].toDate(),
      productId: json['productId']);
}

Map<String, dynamic> _$ProductReviewToJson(ProductReview productReview) =>
    <String, dynamic>{
      'rating': productReview.rating,
      'content': productReview.content,
      'uid': productReview.uid,
      'dateTime': productReview.dateTime,
      'productId': productReview.productId
    };
