import 'dart:convert';

//RestaurantProduct restaurantProductFromJson(String str) => RestaurantProduct.fromJson(json.decode(str));

//String restaurantProductToJson(RestaurantProduct data) => json.encode(data.toJson());

class RestaurantItemDetails {
    int id;
    String name;
    int storeId;
    String description;
    double price;
    int qty;
    double item_total;
    double addon_total;
    String addons;
    String addontext;

    
    RestaurantItemDetails(
        this.id,
        this.name,
        this.storeId,
        this.description,
        this.price,
        this.qty, 
        this.item_total,
        this.addon_total,
        this.addons,
        this.addontext
    );

   

     @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.storeId}, ${this.description}, ${this.price}, ${this.qty}, ${this.item_total}, ${this.addon_total}, ${this.addons},${this.addontext}}';
  }
}
