import 'dart:async';

import 'package:bomberman/button.dart';
import 'package:bomberman/pixel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> fire = [-1];
  int squares = 130;
  int playerPosition = 0;
  int bombPosition = -1;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    19,
    31,
    33,
    35,
    37,
    39,
    51,
    53,
    55,
    57,
    59,
    71,
    73,
    75,
    77,
    79,
    91,
    93,
    95,
    97,
    99,
    111,
    113,
    115,
    117,
    119
  ];

  List<int> boxes = [
    2,
    4,
    6,
    8,
    12,
    14,
    16,
    18,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    32,
    34,
    36,
    38,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    52,
    54,
    56,
    58,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    72,
    74,
    76,
    78,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    92,
    94,
    96,
    98,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    112,
    114,
    116,
    118,
    122,
    124,
    126,
    128
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: squares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int index) {
                  if (bombPosition == index) {
                    return MyPixel(
                      color: Colors.white,
                      child: Image.asset('assets/bomb.png'),
                    );
                  } else if (fire.contains(index)) {
                    return MyPixel(
                      color: Colors.white,
                      child: Image.asset('assets/fire.jpg'),
                    );
                  } else if (playerPosition == index) {
                    return MyPixel(
                      color: Colors.white,
                      child: Image.asset('assets/player.png'),
                    );
                  } else if (barriers.contains(index)) {
                    return MyPixel(
                      color: Colors.grey[700],
                    );
                  } else if (boxes.contains(index)) {
                    return MyPixel(
                      color: Colors.white,
                      child: Image.asset('assets/block.png'),
                    );
                  } else {
                    return MyPixel(
                      color: Colors.white,
                      //child: Text(index.toString()),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(),
                    MyButton(
                      function: moveUp,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_drop_up,
                        size: 60,
                      ),
                    ),
                    MyButton()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      function: moveLeft,
                      longPress: moveLeftFast,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_left,
                        size: 60,
                      ),
                    ),
                    MyButton(
                      function: bomb,
                      color: Colors.grey,
                      child: Image.asset('assets/bomb.png'),
                    ),
                    MyButton(
                      function: moveRight,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_right,
                        size: 60,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(),
                    MyButton(
                      function: moveDown,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 60,
                      ),
                    ),
                    MyButton()
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  void moveDown() {
    setState(() {
      if (playerPosition + 10 < squares &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  void moveLeftFast() {}

  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  void bomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          fire.add(bombPosition);

          if (!(bombPosition % 10 == 9)) {
            if (!barriers.contains(bombPosition + 1)) {
              fire.add(bombPosition + 1);
            }
          }

          if (!(bombPosition % 10 == 0)) {
            if (!barriers.contains(bombPosition - 1)) {
              fire.add(bombPosition - 1);
            }
          }

          if (bombPosition + 10 < squares &&
              !barriers.contains(bombPosition + 10)) {
            fire.add(bombPosition + 10);
          }
          if (bombPosition - 10 >= 0 && !barriers.contains(bombPosition - 10)) {
            fire.add(bombPosition - 10);
          }

          bombPosition = -1;

          //clearFire;
        });

        clearFire();
      });

      //clearFire;
    });
  }

  void clearFire() {
    setState(() {
      if (fire.contains(playerPosition)) {
        print('game over');
        gameOver();
      } else {
        Timer(const Duration(milliseconds: 250), () {
          setState(() {
            for (int i = 0; i < fire.length; i++) {
              if (boxes.contains(fire[i])) {
                boxes.remove(fire[i]);
              }
            }
            fire.clear();
          });
        });
      }
    });
  }

  gameOver() {
    print('game over');
  }
}
