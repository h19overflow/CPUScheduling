import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Algorithms/NPP.dart';
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
      required this.numOfProcess,
      required this.isPriority,
      required this.priority});

  List<int> priority;

  final bool isPriority;
  final List<int> burst;
  final int numOfProcess;
  final List<int> wait;
  final List<int> finish;
  final List<int> turnAround;
  final List<int> arrival;
  bool isnPsjf;

  @override
  Widget build(BuildContext context) {
    // List of columns for the DataTable
    List<DataColumn> columns = [
      const DataColumn(
        label: Text(
          "Process",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
      const DataColumn(
        label: Text(
          'Arrival Time',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
      const DataColumn(
        label: Text(
          'Burst Time',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
      // Conditionally add the 'Priority' column if isPriority is true
      if (isPriority)
        const DataColumn(
          label: Text(
            'Priority',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
          ),
        ),
      const DataColumn(
        label: Text(
          'Finish Time',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
      const DataColumn(
        label: Text(
          'Turnaround Time',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
      const DataColumn(
        label: Text(
          'Waiting Time',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        ),
      ),
    ];

    // Build the rest of your widget tree including the DataTable
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
                columns: columns,
                // Use the dynamically generated list of columns
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
                          ),
                        ),
                        DataCell(
                          Text(
                            '${burst[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Only include the priority cell if isPriority is true
                        if (isPriority)
                          DataCell(
                            Text(
                              '${priority[i]}',
                              // Replace with your actual data for priority
                              style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        DataCell(
                          Text(
                            '${finish[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${turnAround[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${wait[i]}',
                            style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
  FullDataTable({
    super.key,
    required this.algorithmName,
    required this.robinAlgo,
    required this.npsjfAlgo,
    required this.srtf,
    required this.npp,
  });

  final String algorithmName;
  final RoundRobinAlgo robinAlgo;
  final NPSJF npsjfAlgo;
  final SRTF srtf;
  final NPP npp;

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
                          : algorithmName == 'NP Priority'
                              ? npp.burstTime
                              : [],
              arrival: algorithmName == 'Round Robin'
                  ? robinAlgo.arrival
                  : algorithmName == 'NP SJF'
                      ? npsjfAlgo.arrival
                      : algorithmName == 'P SJF'
                          ? srtf.arrivalTime
                          : algorithmName == 'NP Priority'
                              ? npp.arrivalTime
                              : [],
              finish: algorithmName == 'Round Robin'
                  ? robinAlgo.finish
                  : algorithmName == 'NP SJF'
                      ? npsjfAlgo.finishTime
                      : algorithmName == 'P SJF'
                          ? srtf.completionTime
                          : algorithmName == 'NP Priority'
                              ? npp.finishTime
                              : [],
              turnAround: algorithmName == 'Round Robin'
                  ? robinAlgo.turn
                  : algorithmName == 'NP SJF'
                      ? npsjfAlgo.turnAroundTime
                      : algorithmName == 'P SJF'
                          ? srtf.turnaroundTime
                          : algorithmName == 'NP Priority'
                              ? npp.turnaroundTime
                              : [],
              wait: algorithmName == 'Round Robin'
                  ? robinAlgo.wait
                  : algorithmName == 'NP SJF'
                      ? npsjfAlgo.waitingTime
                      : algorithmName == 'P SJF'
                          ? srtf.waitingTime
                          : algorithmName == 'NP Priority'
                              ? npp.waitingTime
                              : [],
              numOfProcess: algorithmName == 'Round Robin'
                  ? robinAlgo.nP
                  : algorithmName == 'NP SJF'
                      ? npsjfAlgo.nP
                      : algorithmName == 'P SJF'
                          ? srtf.nP
                          : algorithmName == 'NP Priority'
                              ? npp.nP
                              : 0,
              isPriority: algorithmName == 'NP Priority' ? true : false,
              priority: algorithmName == 'NP Priority' ? npp.priority : [])
        ],
      ),
    );
  }
}
