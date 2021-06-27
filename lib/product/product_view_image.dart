import 'package:bayya/catalog/catalog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductViewImage extends StatefulWidget {
  final String productId;

  const ProductViewImage({Key key, this.productId}) : super(key: key);
  @override
  _ProductViewImageState createState() => _ProductViewImageState();
}

class _ProductViewImageState extends State<ProductViewImage> {
  String _imgURL = "";

  Future<void> _getImageURL() async {
    var result = await FirebaseStorage.instance
        .ref()
        .child(Provider.of<Catalog>(context)
            .productsCatalog[widget.productId]
            .imageURL)
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
    return Container(
      child: Image.network(
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
            child: Icon(
              Icons.broken_image,
              color: Colors.blue,
            )),
      ),
    );
  }
}
