import 'package:flutter/material.dart';

BoxDecoration get shoppingCartItemDecoration => BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.white),
        color: Colors.white);

BoxDecoration get proudctCardDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.grey[300], spreadRadius: 1)]);
