// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:recipe_cart/features/ingredient/data/ingredient_message_model.dart';

// class IngredientDetectedList extends StatefulWidget {
//   @override
//   _IngredientDetectedListState createState() = _IngredientDetectedListState();
// }

// class _IngredientDetectedListState extends State<IngredientDetectedList> {
//   StreamController<IngredientMessageModel> _streamController;

//   List<IngredientMessageModel> list = [];

//   @override
//   void initState() {
//     super.initState();
//     _streamController = StreamController.broadcast();

//     _streamController.stream.listen((m) => setState(() => list.add(m)));

//     load(_streamController);
//   }


// }