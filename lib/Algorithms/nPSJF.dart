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
