import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NPSJF {
  int nP = 0;
  List<int> burstTime = [];
  List<int> arrival = [];
  List<int> waitingTime = [];
  List<int> turnAroundTime = [];
  List<int> finishTime = [];
  List<int> startTime = [];
  List<bool> completed = [];
  List<int> processOrder = [];
  List<int> finishTimes = [];
  double avgWait = 0;
  double avgTurn = 0;
  List<int> processId = [];

  void nPSJF() {
    int currentTime = 0;
    int completedProcesses = 0;

    while (completedProcesses < nP) {
      int selectedProcess = -1;
      int minBurstTime = 999999999;
      for (int i = 0; i < nP; i++) {
        if (!completed[i] &&
            arrival[i] <= currentTime &&
            (burstTime[i] < minBurstTime ||
                (burstTime[i] == minBurstTime &&
                    arrival[i] < arrival[selectedProcess]))) {
          minBurstTime = burstTime[i];
          selectedProcess = i;
        }
      }

      if (selectedProcess != -1) {
        startTime[selectedProcess] = currentTime; // Track start time
        waitingTime[selectedProcess] = currentTime - arrival[selectedProcess];
        turnAroundTime[selectedProcess] =
            waitingTime[selectedProcess] + burstTime[selectedProcess];
        finishTime[selectedProcess] = currentTime +
            burstTime[selectedProcess]; // Corrected finish time calculation
        currentTime += burstTime[selectedProcess];
        completed[selectedProcess] = true;
        completedProcesses++;
        processOrder.add(processId[selectedProcess]);
      } else {
        avgWait = waitingTime.reduce((a, b) => a + b) / nP;
        avgTurn = turnAroundTime.reduce((a, b) => a + b) / nP;
        currentTime++;
      }
    }
    print(processOrder);

    startTime.sort(
      (a, b) => a.compareTo(b),
    );
    finishTimes = List.of(finishTime);
    finishTimes.sort(
      (a, b) => a.compareTo(b),
    );
    calculateOnPresses();
  }

  void onNumsSaved(String string) {
    nP = int.parse(string);
    arrival = List.filled(nP, 0);
    burstTime = List.filled(nP, 0);
    waitingTime = List.filled(nP, 0);
    turnAroundTime = List.filled(nP, 0);
    finishTime = List.filled(nP, 0);
    startTime = List.filled(nP, 0);
    processId = List.generate(nP, (i) => i);
    completed = List.filled(nP, false);
    finishTimes = List.filled(nP, 0);
    processOrder = [];
  } //0A 1B 2C 3D 4E 5F 6G 7H

  void populateBurst(String n, int index) {
    burstTime[index] = int.parse(n);
  }

  void populateArrival(String s, int index) {
    arrival[index] = int.parse(s);
  }

  void calculateOnPresses() {
    avgWait = calculateAverage(waitingTime);
    avgTurn = calculateAverage(turnAroundTime);
  }

  double calculateAverage(List<int> nums) {
    double average =
        nums.reduce((value, element) => value + element) / nums.length;
    return double.parse(average.toStringAsFixed(3));
  }
}

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
