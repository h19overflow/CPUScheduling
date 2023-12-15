import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Algorithms/SRTF.dart';
import '../../Algorithms/nPSJF.dart';
import '../../Algorithms/rounRobin.dart';

class DataTableCustom extends StatelessWidget {
  DataTableCustom(
      {super.key,
      required this.burst,
      required this.wait,
      required this.finish,
      required this.arrival,
      required this.turnAround,
      required this.isnPsjf,
      required this.numOfProcess});

  final List<int> burst;
  final int numOfProcess;
  final List<int> wait;
  final List<int> finish;
  final List<int> turnAround;
  final List<int> arrival;
  bool isnPsjf;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: FadeInLeft(
          child: Row(
            children: [
              DataTable(
                columnSpacing: 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 2, 8, 37),
                      Color.fromARGB(255, 18, 28, 101),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: const [
                      BoxShadow(color: Colors.black45, blurRadius: 10)
                    ]),
                dividerThickness: .5,
                columns: const [
                  DataColumn(
                    label: Text(
                      "Process",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Arrival Time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Burst Time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Finish Time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Turnaround Time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Waiting Time',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                ],
                rows: [
                  for (int i = 0; i < numOfProcess; i++)
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            'P$i',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${arrival[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ), // Replace with your actual data
                        ),
                        DataCell(
                          Text(
                            '${burst[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ), // Replace with your actual data
                        ),
                        DataCell(
                          Text(
                            '${finish[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ), // Replace with your actual data
                        ),
                        DataCell(
                          Text(
                            '${turnAround[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ), // Replace with your actual data
                        ),
                        DataCell(
                          Text(
                            '${wait[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ), // Replace with your actual data
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullDataTable extends StatelessWidget {
  const FullDataTable(
      {super.key,
      required this.algorithmName,
      required this.robinAlgo,
      required this.npsjfAlgo,
      required this.srtf});

  final String algorithmName;
  final RoundRobinAlgo robinAlgo;
  final NPSJF npsjfAlgo;
  final SRTF srtf;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DataTableCustom(
            isnPsjf: algorithmName == 'Round Robin' ? false : true,
            burst: algorithmName == 'Round Robin'
                ? robinAlgo.burst
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.burstTime
                    : algorithmName == 'P SJF'
                        ? srtf.tempBurstTime
                        : [],
            arrival: algorithmName == 'Round Robin'
                ? robinAlgo.arrival
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.arrival
                    : algorithmName == 'P SJF'
                        ? srtf.arrivalTime
                        : [],
            finish: algorithmName == 'Round Robin'
                ? robinAlgo.finish
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.finishTime
                    : algorithmName == 'P SJF'
                        ? srtf.completionTime
                        : [],
            turnAround: algorithmName == 'Round Robin'
                ? robinAlgo.turn
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.turnAroundTime
                    : algorithmName == 'P SJF'
                        ? srtf.turnaroundTime
                        : [],
            wait: algorithmName == 'Round Robin'
                ? robinAlgo.wait
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.waitingTime
                    : algorithmName == 'P SJF'
                        ? srtf.waitingTime
                        : [],
            numOfProcess: algorithmName == 'Round Robin'
                ? robinAlgo.nP
                : algorithmName == 'NP SJF'
                    ? npsjfAlgo.nP
                    : algorithmName == 'P SJF'
                        ? srtf.nP
                        : 0,
          )
        ],
      ),
    );
  }
}
