class NPP {
  int nP = 0; // Number of Processes
  List<int> arrivalTime = [];
  List<int> burstTime = [];
  List<int> priority = [];
  List<int> waitingTime = [];
  List<int> turnaroundTime = [];
  List<int> finishTime = [];
  double avgWait = 0;
  double avgTurn = 0;

  NPP();

  List<int> ganttProcessId = [];
  List<int> ganttStartTimes = [];
  List<int> ganttFinishTimes = [];

  // void scheduleJobs() {
  //   ganttProcessId.clear();
  //   ganttStartTimes.clear();
  //   ganttFinishTimes.clear();
  //   List<int> ATt = List.from(arrivalTime);
  //   List<int> PPt = List.from(priority);
  //   int CPU = 0; // CPU Current time
  //   int LAT = arrivalTime
  //       .reduce((curr, next) => curr > next ? curr : next); // Last Arrival Time
  //   int MAX_P = priority
  //       .reduce((curr, next) => curr > next ? curr : next); // Max Priority
  //
  //   int j;
  //   while (arrivalTime.any((at) => at <= LAT) && CPU <= 1000) {
  //     int P1 = MAX_P + 1;
  //     j = -1;
  //     for (int i = 0; i < nP; i++) {
  //       if (ATt[i] <= CPU && PPt[i] < P1) {
  //         j = i;
  //         P1 = PPt[i];
  //       }
  //     }
  //
  //     if (j != -1) {
  //       // Capture Gantt chart data
  //       ganttProcessId.add(j);
  //       ganttStartTimes.add(CPU);
  //       ganttFinishTimes.add(CPU + burstTime[j]);
  //       waitingTime[j] = CPU - ATt[j];
  //       finishTime[j] = CPU;
  //       turnaroundTime[j] = waitingTime[j] + burstTime[j];
  //       // Process scheduling calculations
  //       CPU += burstTime[j];
  //       ATt[j] = LAT + 1; // Mark as visited
  //       PPt[j] = MAX_P + 1; // Mark priority as completed
  //     } else {
  //       CPU++;
  //     }
  //   }
  //   avgWait = waitingTime.reduce((a, b) => a + b) / nP;
  //   avgTurn = turnaroundTime.reduce((a, b) => a + b) / nP;
  // }
  void scheduleJobs() {
    ganttProcessId.clear();
    ganttStartTimes.clear();
    ganttFinishTimes.clear();
    List<int> ATt = List.from(arrivalTime);
    List<int> PPt = List.from(priority);
    int CPU = 0; // CPU Current time
    int LAT = arrivalTime
        .reduce((curr, next) => curr > next ? curr : next); // Last Arrival Time
    int MAX_P = priority
        .reduce((curr, next) => curr > next ? curr : next); // Max Priority

    int j;
    while (arrivalTime.any((at) => at <= LAT) && CPU <= 1000) {
      int P1 = MAX_P + 1;
      j = -1;
      for (int i = 0; i < nP; i++) {
        if (ATt[i] <= CPU && PPt[i] < P1) {
          j = i;
          P1 = PPt[i];
        }
      }

      if (j != -1) {
        // Capture Gantt chart data
        ganttProcessId.add(j);
        ganttStartTimes.add(CPU);
        ganttFinishTimes.add(CPU + burstTime[j]);

        // Calculate waiting time and update CPU time
        waitingTime[j] = CPU - ATt[j];
        CPU += burstTime[j];

        // Calculate finish time and turnaround time
        finishTime[j] = CPU;
        turnaroundTime[j] = CPU - ATt[j];

        // Mark as visited and completed
        ATt[j] = LAT + 1;
        PPt[j] = MAX_P + 1;
      } else {
        CPU++;
      }
    }

    // Calculate average wait time and average turnaround time
    avgWait = waitingTime.reduce((a, b) => a + b) / nP;
    avgTurn = turnaroundTime.reduce((a, b) => a + b) / nP;
  }

  void onNumsSaved(String string) {
    nP = int.parse(string);
    arrivalTime = List.filled(nP, 0);
    burstTime = List.filled(nP, 0);
    waitingTime = List.filled(nP, 0);
    turnaroundTime = List.filled(nP, 0);
    finishTime = List.filled(nP, 0);
    priority = List.filled(nP, 0);
  }

  void populateBurst(String n, int index) {
    burstTime[index] = int.parse(n);
  }

  void populatePriority(String s, int index) {
    priority[index] = int.parse(s);
  }

  void populateArrival(String s, int index) {
    arrivalTime[index] = int.parse(s);
  }

  void calculateOnPresses() {
    avgWait = calculateAverage(waitingTime);
    avgTurn = calculateAverage(turnaroundTime);
  }

  double calculateAverage(List<int> nums) {
    double average =
        nums.reduce((value, element) => value + element) / nums.length;
    return double.parse(average.toStringAsFixed(3));
  }

  int totalWaitTime() {
    return waitingTime.reduce((value, element) => value + element);
  }

  int totalTurnTime() {
    return turnaroundTime.reduce((value, element) => value + element);
  }
}
