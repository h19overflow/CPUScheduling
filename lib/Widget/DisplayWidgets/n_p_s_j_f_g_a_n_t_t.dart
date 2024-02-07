import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NPSJFGanttChart extends StatelessWidget {
  NPSJFGanttChart(
      {super.key,
      required this.finishTimes,
      required this.processId,
      required this.startTimes});

  List<int> processId;
  List<int> startTimes;
  List<int> finishTimes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: processId.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            FadeInUp(
              child: Container(
                height: 40,
                width: 90,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 7, 49, 217),
                      Color.fromARGB(255, 52, 71, 255),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: const [
                      BoxShadow(color: Colors.black45, blurRadius: 5)
                    ]),
                child: Center(
                  child: Text(
                    'P${processId[i].toString()}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            FadeInUp(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: startTimes[i].toString().length > 1 ? 55 : 65),
                    child: Text(
                      '${startTimes[i]}',
                      style: GoogleFonts.robotoMono(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ),
                  if (i == finishTimes.length - 1)
                    Container(
                      child: Text(
                        '${finishTimes[i]}',
                        style: GoogleFonts.robotoMono(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
