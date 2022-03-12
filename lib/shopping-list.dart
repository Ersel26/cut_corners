import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';
import 'package:flutter/material.dart';

/*class Ingredient{
  late String name;
  late int amount;
  late String amountType;
  //late bool isDrink;

  //Ingredient(this.name,this.amount,this.amountType,this.isDrink);
  Ingredient({required this.name, required this.amount, required this.amountType});
}*/

/*List<Ingredient> _all = [
  Ingredient(name: "rice", amountNum: 2, amountType: "kg"),
  Ingredient(name: "olive oil", amountNum: 1, amountType: "L"),
];*/
List<Ingredient> _all = all.values.toList();
List<Ingredient> _needs = [];
List<Ingredient> _owned = [];

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  final titleColor = Color(0xff4297a0);
  final titleTextColor = Color(0xffffffff);
  final listBackground = Color(0xff9bc0c3);
  final backgroundColor = Color(0xfff4eae6);
  final itemTextColor = Color(0xffffffff);


  @override
  Widget build(BuildContext context) {

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: titleColor,
                height: 38,
                width: 232,
                child: Center(
                  child: Text(
                      "Shopping List",
                      style: TextStyle(
                        color: titleTextColor,
                        fontSize: 18.0,
                        fontFamily: 'Lexend Peta',
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _all.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 0.0,
                      color: listBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Text(
                              _all[i].amountNum.toString() + " " + _all[i].amountType,
                              style: TextStyle(
                                color: itemTextColor,
                                fontFamily: 'Lexend Peta',
                                fontWeight: FontWeight.w400,
                              ),
                          ),
                        ),
                        title: Text(
                            _all[i].name,
                            style: TextStyle(
                              color: itemTextColor,
                              fontFamily: 'Lexend Peta',
                              fontWeight: FontWeight.w400,
                            ),
                        ),
                        trailing: Icon(
                          !_needs.contains(_all[i]) ? Icons.check_box_outline_blank : Icons.check_box,
                        ),
                        onTap: () {
                          setState(() {
                            if(_needs.contains(_all[i])) {
                              _needs.remove(_all[i]);
                              _owned.add(_all[i]);
                            }
                            else {
                              _owned.remove(_all[i]);
                              _needs.add(_all[i]);
                            }
                          });
                        },
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );

  }
}


