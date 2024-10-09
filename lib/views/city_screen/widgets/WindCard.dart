import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: 180,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                  child: Container(
                    height: 180,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.wind,
                                size: 18,
                                color: Colors.white54,
                              ),
                              Text(
                                ' WIND',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/compass.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: CustomPaint(
                                        size: Size(150, 150),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 1, top: 1.5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 10, sigmaX: 10)),
                                            Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black54,
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'km/h',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.90),
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w900),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
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
