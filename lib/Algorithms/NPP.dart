class NPP {
  int n = 0; // Number of Processes
  List<int> arrivalTime = [];
  List<int> burstTime = [];
  List<int> priority = [];
  List<int> waitingTime = [];
  List<int> turnaroundTime = [];
  List<int> finishTime = [];
  double avgWait = 0;
  double avgTurn = 0;

  NPP();

  void scheduleJobs() {
    List<int> processOrder = List.generate(n, (i) => i);
    int timer = 0; // CPU Current time
    for (int i = 0; i < n; i++) {
      int processID = processOrder[i];
      if (timer < arrivalTime[processID]) {
        timer = arrivalTime[processID];
      }
      waitingTime[processID] = timer - arrivalTime[processID];
      timer += burstTime[processID];
      finishTime[processID] = timer;
      turnaroundTime[processID] = waitingTime[processID] + burstTime[processID];
    }
    avgWait = calculateAverage(waitingTime);
    avgTurn = calculateAverage(turnaroundTime);
  }

  void onNumsSaved(String string) {
    n = int.parse(string);
    arrivalTime = List.filled(n, 0);
    burstTime = List.filled(n, 0);
    waitingTime = List.filled(n, 0);
    turnaroundTime = List.filled(n, 0);
    finishTime = List.filled(n, 0);
  }

  void populateBurst(String n, int index) {
    burstTime[index] = int.parse(n);
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

  void main() {
    var scheduler = NPP();
    scheduler.scheduleJobs();

    print("Finish Times: ${scheduler.finishTime}");
    print("Priority: ${scheduler.priority}");
    print("Turnaround Time: ${scheduler.turnaroundTime}");
    print("Waiting Time: ${scheduler.waitingTime}");
    print("Average Waiting Time: ${scheduler.avgWait}");
    print("Average Turnaround Time: ${scheduler.avgTurn}");
  }
}
