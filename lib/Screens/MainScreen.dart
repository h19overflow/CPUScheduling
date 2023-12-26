import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:osassignment/Widget/DisplayWidgets/Title.dart';
import 'package:osassignment/Widget/DisplayWidgets/data_table.dart';
import 'package:osassignment/Widget/DisplayWidgets/displayResults.dart';
import 'package:osassignment/Widget/InteractionWidgets/ProcessInputs.dart';
import '../Algorithms/SRTF.dart';
import '../Algorithms/nPSJF.dart';
import '../Algorithms/rounRobin.dart';
import '../Widget/DisplayWidgets/GanttChart.dart';
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
  var formKey = GlobalKey<FormState>();
  var numOfprocessController = TextEditingController();
  var timeQuantumController = TextEditingController();
  var burstFormKey = GlobalKey<FormState>();
  var arrivalFormKey = GlobalKey<FormState>();
  String avgTurn = '0';
  String? selectedValue;
  String avgWait = '0';
  String algorithmName = 'Round Robin';
  final List<String> algorithms = ['Round Robin', 'NP SJF', 'P SJF'];
  bool calculationDone = false;
  int numberOfFields = 2;
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
                        }
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
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
                                      }
                                    }
                                  })
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                  }
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                          }
                          calculationComplete();
                          print(calculationDone);
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
                  algorithmName: algorithmName,
                  robinAlgo: robinAlgo,
                  npsjfAlgo: npsjfAlgo,
                  srtf: srtf,
                ),
                const SizedBox(
                  height: 25,
                ),
                DisplayResults(
                    text: algorithmName == 'Round Robin'
                        ? 'Average Waiting Time: ${robinAlgo.avgWait}'
                        : algorithmName == 'NP SJF'
                            ? 'Average Waiting Time: ${npsjfAlgo.avgWait}'
                            : algorithmName == 'P SJF'
                                ? 'Average Waiting Time: ${srtf.avgWait}'
                                : '0'),
                const SizedBox(height: 10),
                DisplayResults(
                    text: algorithmName == 'Round Robin'
                        ? 'Average Turn Time: ${robinAlgo.avgTT}'
                        : algorithmName == 'NP SJF'
                            ? 'Average Turn Time: ${npsjfAlgo.avgTurn}'
                            : algorithmName == 'P SJF'
                                ? 'Average Turn Time: ${srtf.avgTurn}'
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
                          finishTimes: npsjfAlgo.finishTimes,
                          processId: npsjfAlgo.processOrder,
                          startTimes: npsjfAlgo.startTime),
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
}
