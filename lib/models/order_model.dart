// // class Order {
// //   final int id;
// //   final String customerId;
// //   final double total;
// //   final String status;
// //   final DateTime createdAt;
// //   final List<OrderItem> items;

// //   Order({
// //     required this.id,
// //     required this.customerId,
// //     required this.total,
// //     required this.status,
// //     required this.createdAt,
// //     required this.items,
// //   });

// //   factory Order.fromJson(Map<String, dynamic> json) {
// //     return Order(
// //       id: json['id'],
// //       customerId: json['customerId'],
// //       total: json['total'].toDouble(),
// //       status: json['status'],
// //       createdAt: DateTime.parse(json['createdAt']),
// //       items: (json['items'] as List)
// //           .map((item) => OrderItem.fromJson(item))
// //           .toList(),
// //     );
// //   }

// //   get userId => null;

// //   get orderItems => null;

// //   get totalAmount => null;
// // }

// // class OrderItem {
// //   final String productId;
// //   // final String productName;
// //   final int quantity;
// //   final double price;

// //   OrderItem({
// //     required this.productId,
// //     // required this.productName,
// //     required this.quantity,
// //     required this.price,
// //   });

// //   factory OrderItem.fromJson(Map<String, dynamic> json) {
// //     return OrderItem(
// //       productId: json['productId'],
// //       // productName: json['productName'],
// //       quantity: json['quantity'],
// //       price: json['price'].toDouble(),
// //     );
// //   }
// // }

// class Order {
//   int? id;
//   String? userId;
//   int? boutiqueId;
//   num? totalAmount;
//   String? status;
//   String? createdAt;
//   List<OrderItem>? orderItems;

//   Order(
//       {this.id,
//       this.userId,
//       this.boutiqueId,
//       this.totalAmount,
//       this.status,
//       this.createdAt,
//       this.orderItems});

//   Order.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['userId'];
//     boutiqueId = json['boutiqueId'];
//     totalAmount = json['totalAmount'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     if (json['orderItems'] != null) {
//       orderItems = <OrderItem>[];
//       json['orderItems'].forEach((v) {
//         orderItems!.add(new OrderItem.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['boutiqueId'] = this.boutiqueId;
//     data['totalAmount'] = this.totalAmount;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     if (this.orderItems != null) {
//       data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class OrderItem {
//   int? id;
//   String? productId;
//   int? quantity;
//   num? unitPrice;
//   Product? product;

//   OrderItem(
//       {this.id, this.productId, this.quantity, this.unitPrice, this.product});

//   OrderItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['productId'];
//     quantity = json['quantity'];
//     unitPrice = json['unitPrice'];
//     product =
//         json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['productId'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['unitPrice'] = this.unitPrice;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }

// class Product {
//   String? id;
//   String? name;
//   num? price;
//   int? stock;
//   int? boutiqueId;
//   int? sectionId;
//   int? categoryId;

//   Product(
//       {this.id,
//       this.name,
//       this.price,
//       this.stock,
//       this.boutiqueId,
//       this.sectionId,
//       this.categoryId});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     stock = json['stock'];
//     boutiqueId = json['boutiqueId'];
//     sectionId = json['sectionId'];
//     categoryId = json['categoryId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['stock'] = this.stock;
//     data['boutiqueId'] = this.boutiqueId;
//     data['sectionId'] = this.sectionId;
//     data['categoryId'] = this.categoryId;
//     return data;
//   }
// }

class Order {
  int? id;
  String? userId;
  int? boutiqueId;
  num? totalAmount;
  String? status;
  String? createdAt;
  List<OrderItems>? orderItems;

  Order(
      {this.id,
      this.userId,
      this.boutiqueId,
      this.totalAmount,
      this.status,
      this.createdAt,
      this.orderItems});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    boutiqueId = json['boutiqueId'];
    totalAmount = json['totalAmount'];
    status = json['status'];
    createdAt = json['createdAt'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['boutiqueId'] = this.boutiqueId;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  int? id;
  String? productId;
  int? quantity;
  num? unitPrice;
  Product? product;

  OrderItems(
      {this.id, this.productId, this.quantity, this.unitPrice, this.product});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? description;
  num? price;
  int? stock;
  int? boutiqueId;
  int? sectionId;
  int? categoryId;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stock,
      this.boutiqueId,
      this.sectionId,
      this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    boutiqueId = json['boutiqueId'];
    sectionId = json['sectionId'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['boutiqueId'] = this.boutiqueId;
    data['sectionId'] = this.sectionId;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
