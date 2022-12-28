
import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class StarsWidget extends StatelessWidget {
  StarsWidget({
    super.key,
    this.number = 0,
    this.size = 18,
  });

  double? number;
  double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          size: size,
          color: number !> 0 ? favorColors.Yellow : Colors.black,
        ),
        Icon(
          Icons.star,
          size: size,
          color: number !> 1 ? favorColors.Yellow : Colors.black,
        ),
        Icon(
          Icons.star,
          size: size,
          color: number !> 2 ? favorColors.Yellow : Colors.black,
        ),
        Icon(
          Icons.star,
          size: size,
          color: number !> 3 ? favorColors.Yellow : Colors.black,
        ),
        Icon(
          Icons.star,
          size: size,
          color: number !> 4 ? favorColors.Yellow : Colors.black,
        ),
      ],
    );
  }
}


