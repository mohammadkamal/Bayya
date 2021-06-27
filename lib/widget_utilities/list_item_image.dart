import 'package:bayya/catalog/catalog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemImage extends StatefulWidget {
  final String productId;

  const ListItemImage({Key key, @required this.productId}) : super(key: key);

  @override
  _ListItemImage createState() => _ListItemImage();
}

class _ListItemImage extends State<ListItemImage> {
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

  Widget _imageWidget() {
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
          child: Icon(
            Icons.broken_image,
            color: Colors.blue,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getImageURL();
    return Container(width: 100, height: 100, child: _imageWidget());
  }
}
