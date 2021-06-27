# Bayya
An e-commerce flutter application.

## Features
* Shopping Cart & Watchlist tracking
* User Login and registration support
* Reviewing the products
* Different views
* Dynamic search mechanism

## Challenges
* Build list views on demand - less memory
Using ```ListView.builder()``` instead of ```ListView()``` default constructor
Example:
More-memory consuming code

```dart
Widget _listOfProducts() {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: //Check if the list is empty
            Provider.of<ShoppingCart>(context).shoppingItemQuantites.isNotEmpty
                ? Provider.of<ShoppingCart>(context)
                    .shoppingItemQuantites
                    .keys
                    .map((e) {
                    return ShoppingCartItem(productId: e);
                  }).toList()
                : []);
}
```

Less-memory consuming code

```dart
Widget _listOfProducts() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        // Get items count using Provider
        itemCount: Provider.of<ShoppingCart>(context)
            .shoppingItemQuantites
            .keys
            .length,
        itemBuilder: (context, index) {
          return ShoppingCartItem(
              productId: Provider.of<ShoppingCart>(context)
                  .shoppingItemQuantites
                  .keys
                  .elementAt(index));
    });
}
```

* Future code organization
Using ```FutureBuilder``` instead of setting the state manually
Example:
Manual state management

```dart
String _vendor = 'Vendor not provided';

Widget _vendorCard() {
    _getVendorName();
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 2),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [Text('Vendor:')],
          ),
          Row(
            children: [Text(_vendor)],
          )
        ],
      ),
    );
}

Future<void> _getVendorName() async {
    var _result = await Provider.of<VendorsList>(context).getVendorNameByUid(
        Provider.of<Catalog>(context).productsCatalog[widget.productId].vendor);
    _vendor = _result;
}
```

Future state managemet
```dart
Widget _vendorText() {
    return FutureBuilder(
        future: Provider.of<VendorsList>(context).getVendorNameByUid(
            Provider.of<Catalog>(context)
                .productsCatalog[widget.productId]
                .vendor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data,
                style: TextStyle(fontWeight: FontWeight.bold));
          } else {
            return Text("Vendor isn't provieded");
          }
        });
}
```

## Demo & Images
### Video Demo
[![Demo](https://img.youtube.com/vi/mIx5fLc2f2E/0.jpg)](https://www.youtube.com/watch?v=mIx5fLc2f2E)

### Main screen
![List view](docs\homepage_screenshot_listview.jpg)
![Grid view](docs\homepage_screenshot_gridview.jpg)

### Sidebar
![Sidebar](docs\application_sidebar.jpg)

### Product page
![Product main screen](docs\product_screenshot.jpg)
![Added to cart](docs\product_added_to_shopping_cart.jpg)
![Watchlist](docs\product_watchlisted.jpg)
![Reviews](docs\product_reviews.jpg)

### Search page
![Search](docs\search_page.jpg)