import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class MealListEmpty extends StatefulWidget {
  const MealListEmpty({Key? key}) : super(key: key);

  @override
  _MealListEmptyState createState() => _MealListEmptyState();
}

int dayNumber = 0;
bool isVegan = false;
bool isVegetarian = false;
String dropdownDayValue = 'Choose Day Number';
String dropdownChoiceValue = 'Choose Your Eating Habits';
final selectionColor = Colors.amber;
final questionBackground = const Color(0xfff7ac32);
final questionTextColor = const Color(0xffffffff);
final dropdownbackground = const Color(0xff9bc0c3);
final dropdownTextColor = const Color(0xffffffff);
final recreateButtonColor = const Color(0xffff6b00);
final recreateTextColor = const Color(0xffffffff);
final bacgroundColor = const Color(0xfff4eae6);

class _MealListEmptyState extends State<MealListEmpty> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //TODO SCROLLABLE YAPMAYI DENEYELİM Bİ KUCUK EKRANLAR İCİN
    return SizedBox.expand(
      child: Container(
        color: bacgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 100,),
            SizedBox(
              width: 289.0,
              height: 99.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: questionBackground,
                ),
                child: Center(
                  child: Text(
                    "Create Your Meal List",
                    style: TextStyle(
                      color: questionTextColor,
                      fontSize: 20.0,
                      fontFamily: 'Lexend Peta',
                      fontWeight: FontWeight.w400,
                      //fontFamily:
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              child: Container(
                color: dropdownbackground,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 44.0),
                  child: DropdownButton<String>(
                    isExpanded: false,
                    value: dropdownDayValue,
                    icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                    elevation: 16,
                    style: TextStyle(
                        color: dropdownTextColor,
                        fontFamily: 'Lexend Peta',
                        fontWeight: FontWeight.w400,
                    ),
                    dropdownColor: dropdownbackground,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownDayValue = newValue!;
                        dayNumber = int.parse(dropdownDayValue.split(" ")[0]);
                      });
                    },
                    items: <String>['Choose Day Number', '5 days', '10 days', '15 days']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
              child: Container(
                color: dropdownbackground,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton<String>(
                    isExpanded: false,
                    value: dropdownChoiceValue,
                    icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                    elevation: 16,
                    style: TextStyle(
                      color: dropdownTextColor,
                      fontFamily: 'Lexend Peta',
                      fontWeight: FontWeight.w400,
                    ),
                    dropdownColor: dropdownbackground,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownChoiceValue = newValue!;
                        if( dropdownChoiceValue == "Vegan")
                          {
                            isVegan = true;
                          }
                        else if( dropdownChoiceValue == "Vegetarian") {
                          isVegetarian = true;
                        }
                      });
                    },
                    items: <String>['Choose Your Eating Habits', 'Vegan', 'Vegetarian', 'No Restriction']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: recreateButtonColor,
                height: 47.0,
                width: 197.0,
                child: TextButton(
                  child: Text(
                    "Make a Meal List",
                    style: TextStyle(
                      color: recreateTextColor,
                      fontSize: 14.0,
                      fontFamily: 'Krona One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: (dayNumber < 1) ? null:() async {
                    showDialog(barrierDismissible: false,context: context, builder:(context) => Center(child: Column(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Creating New Meal List. Please wait...",
                            style: TextStyle(
                              color: recreateTextColor,
                              fontSize: 10.0,
                              fontFamily: 'Krona One',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    )), );
                    if(makeAgainChc)
                      {
                        await makeAgainFunc();
                        makeAgainChc=false;
                      }
                    createPersonalMealList(dayNumber,isVegan,isVegetarian).then((value) {
                      mealListCheck = false;
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home(),));
                      },);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: recreateButtonColor,
                height: 47.0,
                width: 197.0,
                child: TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: recreateTextColor,
                      fontSize: 14.0,
                      fontFamily: 'Krona One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () async {
                    if(makeAgainChc)
                    {
                      makeAgainChc=false;
                      mealListCheck = false;
                      Navigator.of(context).pop();
                    }
                    else
                      {
                        mealListCheck = false;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home(),));
                      }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
