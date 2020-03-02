import 'dart:math';

class NotifModel {
  final int id;
  final String title;
  bool hasRead = false;

  NotifModel({this.id, this.title});

  String get description => 'Description for $title';
}

class StoreModel {
  final int id;
  final String name;
  final String imgUrl;
  final int price;
  bool liked;

  StoreModel({this.id, this.name, this.imgUrl, this.price, this.liked = false});

  bool equals(StoreModel other) => id == other.id;
}

class TrackingModel {
  final String date;
  final String status;
  final String description;

  TrackingModel({this.date, this.status, this.description});
}

class OrderModel {
  final int id;
  final String status;
  final String shippedDate;
  final int total;
  final List<TrackingModel> trackings;

  OrderModel(
      {this.id, this.status, this.shippedDate, this.total, this.trackings});

  String get title => 'Order #$id';

  String get totalStr => '\$ $total';
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

  List<StoreModel> _storeModels = [];

  List<StoreModel> get storeModels => _storeModels;

  List<ShoppingCartModel> _shoppingCarts = [];

  List<ShoppingCartModel> get shoppingCarts => _shoppingCarts;

  List<NotifModel> _notifs = [];

  List<NotifModel> get notifModels => _notifs;

  List<NotifModel> get newNotifModels =>
      _notifs.where((x) => !x.hasRead).toList();

  List<OrderModel> _orders = [];

  List<OrderModel> get orderModels => _orders;

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal() {
    // Create dummy store model
    for (int i = 1; i <= 7; i++) {
      _storeModels.add(StoreModel(
          id: i,
          name: 'The Greatest Lego of All Time $i',
          imgUrl: 'https://randomuser.me/api/portraits/lego/$i.jpg',
          price: Random().nextInt(1000)));
    }
    // add null img for testing
    _storeModels.add(StoreModel(
        id: _storeModels.length + 1,
        name: 'A Rejected Lego',
        imgUrl: null,
        price: Random().nextInt(1000)));
    // Create dummy notif model
    for (int i = 1; i <= 25; i++) {
      _notifs.add(NotifModel(id: i, title: 'Notification $i'));
    }
    // Create dummy orders on init
    for (int i = 1; i <= 10; i++) {
      _orders.add(OrderModel(
          id: i,
          status: 'Shipped',
          shippedDate: '$i Feb 2020',
          total: 1000,
          trackings: <TrackingModel>[
            TrackingModel(
                date: '10 Feb 2020',
                status: 'Documentation Prepared',
                description: 'Arrived Hub'),
            TrackingModel(
                date: '11 Feb 2020',
                status: 'Booking Arranged',
                description: 'In Transit to Destination'),
            TrackingModel(
                date: '12 Feb 2020',
                status: 'Collected',
                description: 'Awaiting Customs Clearance')
          ]));
    }
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
