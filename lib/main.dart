//import 'package:cut_corners/meal-list-filled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/SigninScreen.dart';
import 'package:cut_corners/custom_icons_icons.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home-empty.dart';
import 'home-filled.dart';
import 'shopping-list.dart';
import 'meal-list-empty.dart';
import 'meal-list-filled.dart';
import 'questionnaire.dart';



void main() => runApp(const ProviderScope(child: MaterialApp(home: SigninScreen())));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final bottomNavigatorBack = Color(0xff9bc0c3);
  final bottomNavigatorIconBack = Color(0xfff7ac32);
  final bottomNavigatorIconFront = Color(0xffffffff);
  int _currentIndex = 1;
  bool isMealListReady=false;


  static List<Widget> pages = <Widget>[
    const ShoppingList(),//const tempPage(),
    mealList.isEmpty ? HomeEmpty() : HomeFilled(),
    mealList.isEmpty ? MealListEmpty() : MealListFilled(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      getUser();
      getAllFoodRecipes();
      getPersonalMealList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMealListReady?Scaffold(
      body: Center(
        child: pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavigatorBack,
        elevation: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        //selectedIconTheme: const IconThemeData(size: 32),
        //unselectedIconTheme: const IconThemeData(size: 24),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: bottomNavigatorIconBack,
              radius: 25,
              child: Icon(
                CustomIcons.shopping_list_icon,
                color: bottomNavigatorIconFront,
                size: 50,
              ),
            ),
            label: "Shop list",

          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.home_icon,
              color: bottomNavigatorIconFront,
              size: 50,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: bottomNavigatorIconBack,
              radius: 25,
              child: Icon(
                CustomIcons.meal_icon,
                color: bottomNavigatorIconFront,
                size: 50,
              ),
            ),
            label: "Meal list",
          ),
        ],
      ),
    )
    :const Center(child: CircularProgressIndicator());
  }

  Future<void> getPersonalMealList()
  async {
    var querySnapshot = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("personalMealList").get();
    for(int i=1;i<querySnapshot.docs.length+1;i++)
    {
      var documentSnapshot = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("personalMealList").doc("day$i").get();
      Map<String, dynamic>? map = documentSnapshot.data();
      List<String> dailyMeal=[documentSnapshot.data()!["breakfast"],documentSnapshot.data()!["lunch"],documentSnapshot.data()!["dinner"]];
      mealList.add(Daily(meals: dailyMeal));
    }
    setState(() {
      isMealListReady=true;
      checkPages();
      if(mealList.isNotEmpty)
        {
          createShoppingList();
        }
    });
  }
  void checkPages()
  {
    pages=<Widget>[
      const ShoppingList(),//const tempPage(),
      mealList.isEmpty ? HomeEmpty() : HomeFilled(),
      mealList.isEmpty ? MealListEmpty() : MealListFilled(),
    ];
  }
}

