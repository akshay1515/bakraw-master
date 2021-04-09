import 'package:bakraw/screen/cart/mycart2.dart';
import 'package:bakraw/screen/newui/newfavourite.dart';
import 'package:bakraw/screen/newui/newhomepage.dart';
import 'package:bakraw/utils/GroceryColors.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentScreen;
  const BottomNav({Key key, @required this.currentScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BakrawPainter(),
            ),
            Center(
              heightFactor: 0.5,
              child: Container(
                height: size.width * 0.17,
                width: size.width * 0.20,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 1, right: 1, bottom: 1, top: 1),
                  child: FloatingActionButton(
                    elevation: 2,
                    backgroundColor: currentScreen == 0
                        ? grocery_colorPrimary_light
                        : Colors.white,
                    onPressed: () {
                      if (currentScreen != 0) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            NewHomepage.Tag, (Route<dynamic> route) => false);
                      }
                    },
                    child: ImageIcon(
                      AssetImage(currentScreen != 0
                          ? 'images/newicons/shopwhite.png'
                          : 'images/newicons/shopcolor.png'),
                      size: 25,
                      color: currentScreen != 0
                          ? grocery_colorPrimary_light
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: IconButton(
                          icon: currentScreen != 1
                              ? ImageIcon(
                                  AssetImage('images/newicons/cartoutline.png'),
                                  size: 25,
                                )
                              : ImageIcon(
                                  AssetImage('images/newicons/cartcolor.png'),
                                  size: 25,
                                  color: grocery_colorPrimary,
                                ),
                          onPressed: () {
                            if (currentScreen != 1) {
                              Navigator.of(context).pushNamed(
                                Mycart2.tag,
                              );
                            }
                          })),
                  Center(
                      child: IconButton(
                          icon: currentScreen != 2
                              ? ImageIcon(
                                  AssetImage(
                                      'images/newicons/favouriteoutline.png'),
                                  size: 25,
                                )
                              : ImageIcon(
                                  AssetImage(
                                      'images/newicons/favouritecolor.png'),
                                  size: 25,
                                  color: grocery_colorPrimary,
                                ),
                          onPressed: () {
                            if (currentScreen != 2) {
                              Navigator.of(context).pushNamed(
                                NewFavourite.Tag,
                              );
                            }
                          })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BakrawPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueGrey.shade100
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 10, 0, 10);
    path.quadraticBezierTo(size.width * 0.4, 10, size.width * 0.4, 10);
    path.arcToPoint(Offset(size.width * 0.6, 20),
        radius: Radius.circular(15.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 10, size.width * 0.6, 10);
    path.quadraticBezierTo(size.width * 0.8, 10, size.width, 10);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
