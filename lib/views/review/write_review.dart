import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_review.dart';
import 'reviews_database.dart';

class WriteReview extends StatefulWidget {
  final String productId;

  const WriteReview({Key key, this.productId}) : super(key: key);
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final _contentController = TextEditingController();
  int _currentRating = -1;

  Widget _reviewContent() {
    return TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _contentController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: 'Write your review',
        ));
  }

  Widget _starButtons() {
    return Row(
        children: List<Widget>.generate(
            5,
            (index) => IconButton(
                onPressed: () => setState(() => _currentRating = index),
                icon: _currentRating < index
                    ? const Icon(Icons.star_border_rounded)
                    : Icon(Icons.star_rounded, color: Colors.yellow[700]))));
  }

  Widget _sendReviewButton() {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        onPressed: _sendReviewData,
        child: const Text('Submit'));
  }

  Future<void> _sendReviewData() async {
    ProductReview _productReview = ProductReview(
        rating: _currentRating + 1,
        dateTime: DateTime.now(),
        uid: FirebaseAuth.instance.currentUser.uid,
        productId: widget.productId,
        content: _contentController.text);

    // Indicates waiting
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )));

    context.read<ReviewsDatabase>().addReview(_productReview).then((value) {
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write a review'),
      ),
      body: ListView(
        children: [_reviewContent(), _starButtons(), _sendReviewButton()],
      ),
    );
  }
}
