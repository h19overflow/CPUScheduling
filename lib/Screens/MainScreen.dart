import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:osassignment/Widget/DisplayWidgets/Title.dart';
import 'package:osassignment/Widget/DisplayWidgets/data_table.dart';
import 'package:osassignment/Widget/DisplayWidgets/displayResults.dart';
import 'package:osassignment/Widget/InteractionWidgets/ProcessInputs.dart';

import '../Algorithms/NPP.dart';
import '../Algorithms/SRTF.dart';
import '../Algorithms/nPSJF.dart';
import '../Algorithms/rounRobin.dart';
import '../Widget/DisplayWidgets/GanttChart.dart';
import '../Widget/DisplayWidgets/n_p_s_j_f_g_a_n_t_t.dart';
import '../Widget/InteractionWidgets/CustomDropDown.dart';
import '../Widget/InteractionWidgets/ElevatedButton.dart';
import '../Widget/InteractionWidgets/HorizontalInputs.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  RoundRobinAlgo robinAlgo = RoundRobinAlgo();
  NPSJF npsjfAlgo = NPSJF();
  SRTF srtf = SRTF();
  NPP npp = NPP();
  var formKey = GlobalKey<FormState>();
  var numOfprocessController = TextEditingController();
  var timeQuantumController = TextEditingController();
  var burstFormKey = GlobalKey<FormState>();
  var arrivalFormKey = GlobalKey<FormState>();
  var priorityFormKey = GlobalKey<FormState>();
  String avgTurn = '0';
  String? selectedValue;
  String avgWait = '0';
  String algorithmName = 'Round Robin';
  final List<String> algorithms = [
    'Round Robin',
    'NP SJF',
    'P SJF',
    'NP Priority'
  ];
  bool calculationDone = false;
  int numberOfFields = 3;
  Widget gantChart = Container(
    height: 120,
  );

  void calculationComplete() {
    calculationDone = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 7, 22, 101),
        Color.fromARGB(255, 63, 77, 162),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 7, 22, 101),
          title: Text(
            algorithmName,
            style: GoogleFonts.robotoMono(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: FadeInUp(
            child: Column(
              children: [
                FadeInUp(
                  child: Lottie.asset('assets/Robot.json', height: 150),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Choose your Algorithm',
                  style: GoogleFonts.robotoMono(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                CustomDropdown(
                  items: algorithms,
                  selectedValue: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                      algorithmName = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                HorizontalInputs(
                  isQuantum: algorithmName == 'Round Robin' ? true : false,
                  formKey: formKey,
                  numOfProcessController: numOfprocessController,
                  timeQuantumController: timeQuantumController,
                  numOfProcessFunction: (p0) {
                    setState(() {
                      if (algorithmName == 'Round Robin') {
                        robinAlgo.onNumsSaved(p0);
                      } else if (algorithmName == 'NP SJF') {
                        npsjfAlgo.onNumsSaved(p0);
                      } else if (algorithmName == 'P SJF') {
                        srtf.onNumsSaved(p0);
                      } else if (algorithmName == 'NP Priority') {
                        npp.onNumsSaved(p0);
                      }
                    });
                  },
                  timeQuantumFunction: (p0) {
                    robinAlgo.intiTimeQuantom(p0);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomElevated(
                  iconData: Icons.check_circle,
                  text: 'Submit number of process',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        if (algorithmName == 'Round Robin') {
                          robinAlgo.onNumsSaved(numOfprocessController.text);
                          robinAlgo.intiTimeQuantom(timeQuantumController.text);
                          numberOfFields = robinAlgo.nP;
                        } else if (algorithmName == 'NP SJF') {
                          npsjfAlgo.onNumsSaved(numOfprocessController.text);
                          numberOfFields = npsjfAlgo.nP;
                        } else if (algorithmName == 'P SJF') {
                          srtf.onNumsSaved(numOfprocessController.text);
                          numberOfFields = srtf.nP;
                        } else if (algorithmName == 'NP Priority') {
                          npp.onNumsSaved(numOfprocessController.text);
                          numberOfFields = npp.nP;
                        }
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(child: const MainTitle(text: 'Arrival Times')),
                FadeInLeft(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 2, 8, 37),
                              Color.fromARGB(255, 18, 28, 101),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: const [
                          BoxShadow(color: Colors.black45, blurRadius: 10)
                        ]),
                    height: 100,
                    child: Form(
                      key: arrivalFormKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int index = 0; index < numberOfFields; index++)
                              ProcessInputs(
                                validatorFunction: (value) {
                                  if (value == null) {
                                    return 'Enter A value';
                                  } else if (value.isEmpty) {
                                    return 'Enter A value';
                                  }
                                  return null;
                                },
                                index: index,
                                inputHint: 'AT',
                                burstFormKey: arrivalFormKey,
                                populateFunction: (p0) {
                                  if (algorithmName == 'Round Robin') {
                                    robinAlgo.populateArrival(p0!, index);
                                  } else if (algorithmName == 'NP SJF') {
                                    npsjfAlgo.populateArrival(p0!, index);
                                  } else if (algorithmName == 'P SJF') {
                                    srtf.populateArrival(p0!, index);
                                  } else if (algorithmName == 'NP Priority') {
                                    npp.populateArrival(p0!, index);
                                  }
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUp(child: const MainTitle(text: 'Burst Times')),
                FadeInLeft(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 2, 8, 37),
                              Color.fromARGB(255, 18, 28, 101),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: const [
                          BoxShadow(color: Colors.black45, blurRadius: 10)
                        ]),
                    height: 90,
                    child: Form(
                      key: burstFormKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int index = 0; index < numberOfFields; index++)
                              ProcessInputs(
                                  validatorFunction: (value) {
                                    if (value == null) {
                                      return 'Enter A value';
                                    } else if (value.isEmpty) {
                                      return 'Enter A value';
                                    } else if (int.parse(value) <= 0) {
                                      return 'Enter A more than 0';
                                    }
                                    return null;
                                  },
                                  index: index,
                                  inputHint: 'BT',
                                  burstFormKey: burstFormKey,
                                  populateFunction: (newValue) {
                                    if (burstFormKey.currentState!.validate()) {
                                      if (algorithmName == 'Round Robin') {
                                        robinAlgo.populateBurst(
                                            newValue!, index);
                                      } else if (algorithmName == 'NP SJF') {
                                        npsjfAlgo.populateBurst(
                                            newValue!, index);
                                      } else if (algorithmName == 'P SJF') {
                                        srtf.populateBurst(newValue!, index);
                                      } else if (algorithmName ==
                                          'NP Priority') {
                                        npp.populateBurst(newValue!, index);
                                      }
                                    }
                                  })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                algorithmName == 'NP Priority'
                    ? Column(
                        children: [
                          FadeInUp(child: const MainTitle(text: 'Priorities')),
                          FadeInLeft(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 2, 8, 37),
                                        Color.fromARGB(255, 18, 28, 101),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 10)
                                  ]),
                              height: 90,
                              child: Form(
                                key: priorityFormKey,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int index = 0;
                                          index < numberOfFields;
                                          index++)
                                        ProcessInputs(
                                            validatorFunction: (value) {
                                              if (value == null) {
                                                return 'Enter A value';
                                              } else if (value.isEmpty) {
                                                return 'Enter A value';
                                              } else if (int.parse(value) <=
                                                  0) {
                                                return 'Enter A more than 0';
                                              }
                                              return null;
                                            },
                                            index: index,
                                            inputHint: 'P',
                                            burstFormKey: priorityFormKey,
                                            populateFunction: (newValue) {
                                              npp.populatePriority(
                                                  newValue!, index);
                                            })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: CustomElevated(
                    iconData: Icons.add,
                    text: 'Calculate Algorithm',
                    function: () {
                      if (burstFormKey.currentState!.validate() &&
                          arrivalFormKey.currentState!.validate()) {
                        burstFormKey.currentState!.save();
                        arrivalFormKey.currentState!.save();

                        setState(() {
                          if (algorithmName == 'Round Robin') {
                            robinAlgo.roundRobin();
                          } else if (algorithmName == 'NP SJF') {
                            npsjfAlgo.nPSJF();
                          } else if (algorithmName == 'P SJF') {
                            srtf.srtfAlgo();
                          } else if (algorithmName == 'NP Priority' &&
                              priorityFormKey.currentState!.validate()) {
                            priorityFormKey.currentState!.save();
                            npp.scheduleJobs();
                          }
                          calculationComplete();
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomElevated(
                    iconData: Icons.restart_alt,
                    text: 'Restart?',
                    function: () {
                      {
                        if (algorithmName == 'Round Robin') {
                          robinAlgo.onNumsSaved(numOfprocessController.text);
                          robinAlgo.intiTimeQuantom(timeQuantumController.text);
                        } else if (algorithmName == 'NP SJF') {
                          npsjfAlgo.onNumsSaved(numOfprocessController.text);
                        } else if (algorithmName == 'P SJF') {
                          srtf.onNumsSaved(numOfprocessController.text);
                        }
                      }
                    },
                  ),
                ),
                const MainTitle(text: 'Data Table'),
                FullDataTable(
                  npp: npp,
                  algorithmName: algorithmName,
                  robinAlgo: robinAlgo,
                  npsjfAlgo: npsjfAlgo,
                  srtf: srtf,
                ),
                const SizedBox(
                  height: 25,
                ),
                if (calculationDone)
                  DisplayResults(
                      text: algorithmName == 'Round Robin'
                          ? 'Total Waiting Time: ${total(robinAlgo.wait)}/${robinAlgo.nP}\nAverage Waiting Time: ${robinAlgo.avgWait}'
                          : algorithmName == 'NP SJF'
                              ? 'Total Waiting Time ${total(npsjfAlgo.waitingTime)}/${npsjfAlgo.nP}\n Average Waiting Time: ${npsjfAlgo.avgWait}'
                              : algorithmName == 'P SJF'
                                  ? 'Total Waiting Time ${total(srtf.waitingTime)}/${srtf.nP}\n Average Waiting Time: ${srtf.avgWait}'
                                  : algorithmName == 'NP Priority'
                                      ? 'Total Waiting Time: ${total(npp.waitingTime)}/${npp.nP}\n '
                                          'Average Waiting Time:${npp.avgWait}'
                                      : '0'),
                const SizedBox(height: 10),
                if (calculationDone)
                  DisplayResults(
                      text: algorithmName == 'Round Robin'
                          ? 'Total Turn Time:  ${total(robinAlgo.turn)}/${robinAlgo.nP}\nAverage Turn Time: ${robinAlgo.avgTT}'
                          : algorithmName == 'NP SJF'
                              ? 'Total Turn Time: ${total(npsjfAlgo.turnAroundTime)}/${npsjfAlgo.nP}\nAverage Turn Time: ${npsjfAlgo.avgTurn}'
                              : algorithmName == 'P SJF'
                                  ? 'Total Turn Time: ${total(srtf.turnaroundTime)}/${srtf.nP}\nAverage Turn Time: ${srtf.avgTurn}'
                                  : algorithmName == 'NP Priority'
                                      ? 'Total Turn Time: ${total(npp.turnaroundTime)}/${npp.nP}\n '
                                          'Average Turn Time:${npp.avgTurn}'
                                      : '0'),
                const MainTitle(text: 'Gantt Chart'),
                const SizedBox(
                  height: 20,
                ),
                if (calculationDone)
                  if (algorithmName == 'Round Robin' ||
                      algorithmName == 'P SJF')
                    Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: GantChart(
                          gantChart: algorithmName == 'Round Robin'
                              ? robinAlgo.ganttChart
                              : srtf.timeSlices),
                    )
                  else if (calculationDone)
                    Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: NPSJFGanttChart(
                          finishTimes: algorithmName == 'NP SJF'
                              ? npsjfAlgo.finishTimes
                              : npp.ganttFinishTimes,
                          processId: algorithmName == 'NP SJF'
                              ? npsjfAlgo.processOrder
                              : npp.ganttProcessId,
                          startTimes: algorithmName == 'NP SJF'
                              ? npsjfAlgo.startTime
                              : npp.ganttStartTimes),
                    ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int total(List<int> list) {
    if (list.isEmpty) {
      return 0;
    }
    return list.reduce((value, element) => value + element);
  }
}
