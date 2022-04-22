import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductViewImage extends StatefulWidget {
  final String imageURL;

  const ProductViewImage({Key key, this.imageURL}) : super(key: key);
  @override
  _ProductViewImageState createState() => _ProductViewImageState();
}

class _ProductViewImageState extends State<ProductViewImage> {
  String _imgURL = "";

  Future<void> _getImageURL() async {
    var result = await FirebaseStorage.instance
        .ref()
        .child(widget.imageURL)
        .getDownloadURL();

    if (_imgURL == null || _imgURL.isEmpty) {
      setState(() {
        _imgURL = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getImageURL();
    return Image.network(
      _imgURL,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ));
      },
      errorBuilder: (context, error, stackTrace) => Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.broken_image,
            color: Colors.blue,
          )),
    );
  }
}
