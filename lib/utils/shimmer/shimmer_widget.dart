
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/shimmer/shimmer_container_widget.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Change to min
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(183, 226, 213, 213),
                  highlightColor: const Color.fromRGBO(245, 245, 245, 1),
                  enabled: _enabled,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection:Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Container(width:swidth/5 ,height: sheight/9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),),
                        );
                        }),
                      ),
                      ShimmerContainerWidget(sheight / 4, swidth),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ShimmerContainerWidget(sheight / 3, swidth/2.3),
                       horizontalSpaceMedium,
                       ShimmerContainerWidget(sheight / 3, swidth/2.3),
                        ],
                      ),
                        const SizedBox(height: 10),
                      Row(
                        children: [
                          ShimmerContainerWidget(sheight / 3, swidth/2.3),
                       horizontalSpaceMedium,
                       ShimmerContainerWidget(sheight / 3, swidth/2.3),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300, // Specify a finite height
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerContainerWidget(sheight / 5, sheight / 5),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ShimmerContainerWidget(8.0, swidth / 4),
                                      const SizedBox(height: 10),
                                      ShimmerContainerWidget(8.0, swidth / 4),
                                      const SizedBox(height: 10),
                                      ShimmerContainerWidget(8.0, swidth / 4),
                                      const SizedBox(height: 10),
                                      ShimmerContainerWidget(8.0, swidth / 4.5)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
