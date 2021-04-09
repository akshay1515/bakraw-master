import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BakrawUniqueness extends StatelessWidget {
  List<String> title = [
    'Hygenic',
    'Fresh',
    'Traceable',
    'Farm to Fork',
    'Free Delivery'
  ];
  List<String> imageList = [
    'images/newicons/hygenicwhite.png',
    'images/newicons/freshwhite.png',
    'images/newicons/traceablewhite.png',
    'images/newicons/farmforkwhite.png',
    'images/newicons/freedeliverywhite.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: title.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: title.length),
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        color: Colors.white,
                        strokeWidth: 1,
                        padding: EdgeInsets.all(3),
                        child: Center(
                          child: Container(
                              child: Image.asset(
                            imageList[index],
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          )),
                        ),
                      ),
                    ),
                    Text(
                      title[index],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ));
          }),
    );
  }
}
