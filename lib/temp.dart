import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/profilePage.dart';
import 'package:cut_corners/recipe_page.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//FIREBASELERLE RAHAT UGRASAMAK İCİN SAYFA
class tempPage extends StatefulWidget {
  const tempPage({Key? key}) : super(key: key);



  @override
  State<tempPage> createState() => _tempPageState();
}

class _tempPageState extends State<tempPage> {
  bool isFirebaseInit=false;
  @override
  void initState() {
    super.initState();
  }
  Future<void> initializeFirebase() async{
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInit=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    //var foodRecipeRep = FoodRecipeRepository().foodRecipeRep;
    return Scaffold(
      body:ListView.builder(
        itemCount: foodRecipeRep.length+2,
        itemBuilder: (context, index) {
          String key= (index==foodRecipeRep.length)?"Profile":(index==foodRecipeRep.length+1)?"up":foodRecipeRep.keys.elementAt(index);
          return ListTile(
            title: Text(key),
            onTap:(){
              if(index==foodRecipeRep.length+1)
              {
                //uploadFood();
                //print(foodRecipeRep.length);
                //printFoods();
                //clear();
                //categorizeFoods();
                //createPersonalMealList();
                //print(mealList.isEmpty);

              }
              else if(index==foodRecipeRep.length)
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
              }
              else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: key)));
              }},
          );
        },
      ),
    );
  }

  void uploadFood()
  {
    for (var food in exampleFoods) {
      final name=food.name;
      FirebaseFirestore.instance.collection("food_recipe").doc(name).set(food.toMap());
      for(var i in food.ingredients)
      {
        FirebaseFirestore.instance.collection("food_recipe").doc(name).collection("ingredients").doc(i.name).set(i.toMap());
      }
    }
  }

  void categorizeFoods()
  {
      for(var element in foodRecipeRep.keys)
        {
          var food=foodRecipeRep[element];
          if(food!.calories<1000)
            {
              FirebaseFirestore.instance.collection("calorieList").doc("700-1000").collection("foodNames").doc(food.name).set({"name":food.name});
            }
          else if(food!.calories<1300)
          {
            FirebaseFirestore.instance.collection("calorieList").doc("1000-1300").collection("foodNames").doc(food.name).set({"name":food.name});
          }
          else
          {
            FirebaseFirestore.instance.collection("calorieList").doc("1300-1600").collection("foodNames").doc(food.name).set({"name":food.name});
          }

        }
  }
}

void clear()
{
  var documentReference = FirebaseFirestore.instance.collection("calorieList").doc("700-1000");
  documentReference.collection("foodNames").snapshots().forEach((element) {
    for(QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot  in element.docs)
    {
      docSnapshot .reference.delete();
    }
  });
  documentReference = FirebaseFirestore.instance.collection("calorieList").doc("1000-1300");
  documentReference.collection("foodNames").snapshots().forEach((element) {
    for(QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot  in element.docs)
    {
      docSnapshot .reference.delete();
    }
  });
  documentReference = FirebaseFirestore.instance.collection("calorieList").doc("1300-1600");
  documentReference.collection("foodNames").snapshots().forEach((element) {
    for(QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot  in element.docs)
    {
      docSnapshot .reference.delete();
    }
  });
}