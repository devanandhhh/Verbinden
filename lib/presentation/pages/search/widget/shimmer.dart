
import 'package:flutter/material.dart';

class ShimmerLoadingGridView extends StatelessWidget {
  const ShimmerLoadingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 20, // Number of items in the grid
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          // child: sizedboxWithCircleprogressIndicator()
        );
      },
    );
  }
}
