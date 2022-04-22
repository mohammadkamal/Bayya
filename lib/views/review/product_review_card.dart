import 'package:bayya/models/product_review.dart';
import 'package:bayya/user/customer_database.dart';
import 'package:bayya/views/review/reviews_database.dart';
import 'package:bayya/views/widgets/stateless_widgets/sign_in_to_perfom_action.dart';
import 'package:bayya/views/widgets/styles/box_decorations.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_reviews_list.dart';
import 'write_review.dart';

class ProductReviewCard extends StatefulWidget {
  final String productId;

  const ProductReviewCard({Key key, this.productId}) : super(key: key);
  @override
  _ProductReviewCardState createState() => _ProductReviewCardState();
}

class _ProductReviewCardState extends State<ProductReviewCard> {
  Widget _previewReview(ProductReview review) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _nameOfReviewer(review.uid),
                Text(DateTime.now()
                        .difference(review.dateTime)
                        .inDays
                        .toString() +
                    'd ago')
              ],
            ),
            Text(review.content),
            Row(
              children: _stars(review.rating),
            )
          ],
        ));
  }

  List<Widget> _stars(int rating) {
    List<Widget> _list = List<Widget>.generate(5, (index) {
      if (index < rating) {
        return Icon(Icons.star_rounded, color: Colors.yellow[700]);
      } else {
        return const Icon(Icons.star_outline_rounded);
      }
    });
    return _list;
  }

  Widget _nameOfReviewer(String uid) {
    return FutureBuilder(
        future: Provider.of<CustomerDatabase>(context).getAccountNameEmail(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['displayName'].isNotEmpty) {
              return Text(snapshot.data['displayName']);
            } else {
              return Text(snapshot.data['email']);
            }
          } else {
            return const Text('Name is not provided');
          }
        });
  }

  Widget _noReviewsData() {
    return const Text('No reviews yet...');
  }

  Widget _writeReviewButton() {
    return FutureBuilder(
        future: Provider.of<ReviewsDatabase>(context).isUserReviewedProduct(
            FirebaseAuth.instance.currentUser.uid, widget.productId),
        builder: (context, snapshot) {
          return TextButton(
              onPressed: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  showDialog(
                      context: context,
                      builder: (context) => const SignInToPerfomAction());
                } else {
                  if (!snapshot.data) {
                    Navigator.of(context).push(TweenAnimationRoute()
                        .playAnimation(
                            WriteReview(productId: widget.productId)));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => _duplicateReviewDialog());
                  }
                }
              },
              child: const Text('Write a review'));
        });
  }

  Widget _duplicateReviewDialog() {
    return AlertDialog(
        title: const Text('Duplicate'),
        content: const Text('You already reviewed this product!'),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.pop(context),
          )
        ]);
  }

  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        _writeReviewButton()
      ],
    );
  }

  Widget _showAllReviewsButton() {
    return TextButton(
        onPressed: () => Navigator.of(context)
                .push(TweenAnimationRoute().playAnimation(ProductReviewsList(
              productId: widget.productId,
            ))),
        child: const Text('Show all reviews'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ReviewsDatabase>(context)
            .fetchReviewByIndex(widget.productId, 0),
        builder: (context, snapshot) {
          return Container(
              padding: const EdgeInsets.all(5),
              decoration: proudctCardDecoration,
              child: Column(children: [
                _topRow(),
                snapshot.hasData
                    ? _previewReview(snapshot.data)
                    : _noReviewsData(),
                _showAllReviewsButton()
              ]));
        });
  }
}
