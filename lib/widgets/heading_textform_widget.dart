import 'package:flutter/material.dart';

class HeadingTextFormWidget extends StatelessWidget {
  const HeadingTextFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'What are you looking for',
                ),
              );
  }
}