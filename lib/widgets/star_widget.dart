import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class StarWidget extends StatelessWidget {
//   double value;
//   StarWidget({required this.value});

  
//   Widget build(BuildContext context) {
//     return RatingStars(
//           axis: Axis.horizontal,
//           value:value,
//           // onValueChanged: (v) {
//           //   starRating.value = v;
//           // },
//           starCount:value.ceil() ,
//           starSize: 20,
//           valueLabelColor: const Color(0xff9b9b9b),
//           valueLabelTextStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w400,
//               fontStyle: FontStyle.normal,
//               fontSize: 12.0),
//           valueLabelRadius: 10,
//           maxValue: value,
//           starSpacing: 2,
//           maxValueVisibility: true,
//           valueLabelVisibility: false,
//           animationDuration: Duration(milliseconds: 1000),
//           valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//           valueLabelMargin: const EdgeInsets.only(right: 8),
//           starOffColor: const Color(0xffe7e8ea),
//           starColor:Colors.yellow, // Dynamic star color
//           angle: 0,
//         );  }
// }

import 'package:flutter/material.dart';
import 'package:kascollection/utils/constant.dart';


class StarWidget extends StatelessWidget {
  final double value; // Rating value (e.g., 1.5)
  final int starCount; // Number of stars
  final double starSize; // Size of the stars
 // Color for filled stars
  final Color halfStarColor; // Color for half-filled stars
  // Color for empty stars

  StarWidget({
    required this.value,
    this.starCount = 5, // Default number of stars
    this.starSize = 15,
   
    this.halfStarColor = Colors.yellowAccent,
    
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 0; i < value.ceil(); i++) {
      // Full star
      if (i < value.floor()) {
        stars.add(Icon(
          Icons.star,
          color: sandleColor,
          size: starSize,
        ));
      }
      // Half star
      else if (i == value.floor() && value - value.floor() > 0) {
        stars.add(Icon(
          Icons.star_half,
          color:  sandleColor,
          size: starSize,
        ));
      }
      // Empty star
      // else {
      //   stars.add(Icon(
      //     Icons.star_border,
      //     color: emptyStarColor,
      //     size: starSize,
      //   ));
      //
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
