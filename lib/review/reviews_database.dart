import 'package:bayya/review/product_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ReviewsDatabase extends ChangeNotifier {
  CollectionReference reviewsCollection =
      FirebaseFirestore.instance.collection('reviews');
  CollectionReference reviewsByProducts =
      FirebaseFirestore.instance.collection('reviewsByProducts');
  CollectionReference customerReviews =
      FirebaseFirestore.instance.collection('customerReviews');

  Future<List<dynamic>> fetchReviewEntries(String productId) async {
    final DocumentSnapshot<Map<String, dynamic>> _documentForIDs =
        await reviewsByProducts.doc(productId).get();
    return _documentForIDs.data().keys.toList();
  }

  Future<ProductReview> fetchReview(String reviewId) async {
    DocumentSnapshot<Map<String, dynamic>> _doc =
        await reviewsCollection.doc(reviewId).get();
    return ProductReview.fromJson(_doc.data());
  }

  Future<ProductReview> fetchReviewByIndex(String productId, int index) async {
    final DocumentSnapshot<Map<String, dynamic>> _documentForIDs =
        await reviewsByProducts.doc(productId).get();
    var _tempData = _documentForIDs.data().keys.elementAt(index);
    DocumentSnapshot<Map<String, dynamic>> _documentForReview =
        await reviewsCollection.doc(_tempData).get();
    return ProductReview.fromJson(_documentForReview.data());
  }

  Future<bool> isUserReviewedProduct(String uid, String productId) async {
    DocumentSnapshot<Map<String, dynamic>> _doc =
        await customerReviews.doc(uid).get();
    if (_doc.data().containsKey(productId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addReview(ProductReview productReview) async {
    // Add to review collections
    // Generate review document
    var reviewDocument = reviewsCollection.doc();
    // Get document id
    var reviewId = reviewDocument.id;
    // Set data to document
    reviewDocument.set(productReview.toJson());

    // Add review id to user reviews document
    customerReviews
        .doc(productReview.uid)
        .update({productReview.productId: reviewId});

    DocumentSnapshot<Map<String, dynamic>> _revByProd =
        await reviewsByProducts.doc(productReview.productId).get();
    if (_revByProd.exists) {
      // Add review to reviews by product collection
      reviewsByProducts.doc(productReview.productId).update({reviewId: null});
    } else {
      reviewsByProducts.doc(productReview.productId).set({reviewId: null});
    }
  }
}
