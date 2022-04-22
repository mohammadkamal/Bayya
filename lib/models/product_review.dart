import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReview {
  String id;
  int rating;
  DocumentReference user;
  DocumentReference product;
  String content;
  DateTime timeAdded;

  ProductReview(
      {this.id,
      this.rating,
      this.content,
      this.user,
      this.timeAdded,
      this.product});

  factory ProductReview.fromJson(Map<String, dynamic> map) {
    return ProductReview(
        id: map['id'],
        rating: map['rating'],
        content: map['content'],
        user: map['user'],
        timeAdded: (map['timeAdded']).toDate(),
        product: map['productId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'content': content,
      'user': user,
      'timeAdded': Timestamp.fromDate(timeAdded),
      'product': product
    };
  }

  @override
  String toString() {
    return 'ProductReview(id: $id, rating: $rating, content: $content, user: $user, timeAdded: $timeAdded, product: $product)';
  }
}
