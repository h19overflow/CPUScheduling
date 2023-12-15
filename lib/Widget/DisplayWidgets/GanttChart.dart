import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class GantChart extends StatelessWidget {
  GantChart({required this.gantChart});

  final List<List<int>> gantChart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (var index = 0; index < gantChart.length; index++)
          if (gantChart[index][1] - gantChart[index][2] != 0)
            Column(
              children: [
                FadeInUp(
                  child: Container(
                    height: 40,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 7, 49, 217),
                              Color.fromARGB(255, 52, 71, 255),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: const [
                          BoxShadow(color: Colors.black54, blurRadius: 5)
                        ]),
                    child: Center(
                      child: Text(
                        'P${gantChart[index][0] - 1}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  child: Row(
                    children: [
                      Container(
                          padding: gantChart[index][1].toString().length > 1
                              ? const EdgeInsets.only(right: 58)
                              : const EdgeInsets.only(right: 82),
                          child: Text(
                            gantChart[index][1].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  ),
                ),
              ],
            ),
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            gantChart.last[2].toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
