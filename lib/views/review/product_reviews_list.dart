import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user/customer_database.dart';
import '../widgets/styles/box_decorations.dart';
import 'reviews_database.dart';

class ShowProductReview extends StatefulWidget {
  final String reviewId;

  const ShowProductReview({Key key, this.reviewId}) : super(key: key);

  @override
  _ShowProductReviewState createState() => _ShowProductReviewState();
}

class _ShowProductReviewState extends State<ShowProductReview> {
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

  List<Widget> _stars(int rating) {
    List<Widget> _list = List<Widget>.generate(5, (index) {
      if (index < rating) {
        return Icon(Icons.star_rounded, color: Colors.yellow[700]);
      } else {
        return const Icon(Icons.star_border_rounded);
      }
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<ReviewsDatabase>(context).fetchReview(widget.reviewId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: proudctCardDecoration,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _nameOfReviewer(snapshot.data.uid),
                        Text(DateTime.now()
                                .difference(snapshot.data.dateTime)
                                .inDays
                                .toString() +
                            'd ago')
                      ],
                    ),
                    Text(snapshot.data.content),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _stars(snapshot.data.rating),
                    )
                  ],
                ));
          } else {
            return const Text('No data available');
          }
        });
  }
}

class ProductReviewsList extends StatefulWidget {
  final String productId;

  const ProductReviewsList({Key key, this.productId}) : super(key: key);
  @override
  _ProductReviewsListState createState() => _ProductReviewsListState();
}

class _ProductReviewsListState extends State<ProductReviewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reviews'),
        ),
        body: FutureBuilder(
          future: Provider.of<ReviewsDatabase>(context)
              .fetchReviewEntries(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data.map<Widget>((element) {
                return ShowProductReview(
                  reviewId: element,
                );
              }).toList());
            } else {
              return const Text('No reviews yet...');
            }
          },
        ));
  }
}
