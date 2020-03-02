import 'dart:math';

class StoreModel {
  final int id;
  final String name;
  final String imgUrl;
  final int price;
  bool liked;

  StoreModel({this.id, this.name, this.imgUrl, this.price, this.liked = false});

  bool equals(StoreModel other) => id == other.id;
}

class ShoppingCartModel {
  int qty = 1;
  final StoreModel store;

  ShoppingCartModel({this.store});

  String get name => store.name;

  String get description => 'Description for $name';

  String get priceStr => '\$ ${store.price * qty}';
}

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();

  List<StoreModel> storeModels = [];

  List<ShoppingCartModel> _shoppingCarts = [];

  List<ShoppingCartModel> get shoppingCarts => _shoppingCarts;

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal() {
    for (int i = 1; i <= 7; i++) {
      storeModels.add(StoreModel(
          id: i,
          name: 'The Greatest Lego of All Time $i',
          imgUrl: 'https://randomuser.me/api/portraits/lego/$i.jpg',
          price: Random().nextInt(1000)));
    }
    // add null img for testing
    storeModels.add(StoreModel(
        id: storeModels.length + 1,
        name: 'A Rejected Lego',
        imgUrl: null,
        price: Random().nextInt(1000)));
  }

  void addShoppingCart(StoreModel storeModel) {
    // Check if exist in the list first
    ShoppingCartModel scModel = _shoppingCarts
        .singleWhere((x) => x.store.equals(storeModel), orElse: () => null);
    // If exists, add the qty of the current SC item
    if (scModel != null) {
      scModel.qty++;
    }
    // Otherwise, create a new one
    else {
      _shoppingCarts.add(ShoppingCartModel(store: storeModel));
    }
  }
}
