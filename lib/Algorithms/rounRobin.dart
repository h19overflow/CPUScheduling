class RoundRobinAlgo {
  int nP = 0;
  int tq = 0;
  int maxProcessIndex = 0;
  double avgWait = 0;
  double avgTT = 0;
  int startTime = 0;
  int endTime = 0;
  List<int> arrival = [];
  List<int> burst = [];
  List<int> wait = [];
  List<int> turn = [];
  List<int> finish = [];
  List<int> queue = [];
  List<int> tempBurst = [];
  List<bool> complete = [];
  List<bool> processed = [];
  List<List<int>> ganttChart = [];

  void updateGanttChart(int processIndex, int startTime, int endTime) {
    ganttChart.add([processIndex, startTime, endTime]);
  }

  List<List<int>> roundRobin() {
    ganttChart.clear();
    arrival.sort((a, b) => a.compareTo(b));
    int timer = 0;
    for (int i = 0; i < nP; i++) {
      queue[i] = 0;
    }
    while (timer < arrival[0]) {
      timer++;
    }
    queue[0] = 1;
    while (true) {
      bool allProcessesCompleted = complete.every((element) => true);
      bool tempBurstFinished = tempBurst.every((val) => val == 0);
      if (tempBurstFinished && allProcessesCompleted) break;
      for (int i = 0; (i < nP) && (queue[i] != 0); i++) {
        int ctr = 0;
        int startTime = timer;
        while ((ctr < tq) && (tempBurst[queue[0] - 1] > 0)) {
          tempBurst[queue[0] - 1] -= 1;
          timer++;
          ctr++;
          processed[queue[0] - 1] = true;
          checkNewArrival(timer, arrival, nP, maxProcessIndex, queue);
          maxProcessIndex = queue.indexOf(queue.lastWhere((val) => val != 0));
        }
        int endTime = timer;
        updateGanttChart(queue[0], startTime, endTime);
        if ((tempBurst[queue[0] - 1] == 0) && (!complete[queue[0] - 1])) {
          turn[queue[0] - 1] = timer;
          finish[queue[0] - 1] = timer;
          complete[queue[0] - 1] = true;
          print('block 4');
        }
        bool idle = queue[nP - 1] == 0
            ? queue
                .takeWhile((val) => val != 0)
                .every((val) => complete[val - 1])
            : false;
        if (idle) {
          // timer++;
          timer = checkNewArrival(timer, arrival, nP, maxProcessIndex,
              queue); // Update the timer value
        }
        for (int j = 0; j < nP; j++) {
          if (arrival[j] <= timer &&
              tempBurst[j] > 0 &&
              !queue.contains(j + 1)) {
            queue[j] = j + 1;
          }
        }
        checkNewArrival(timer, arrival, nP, maxProcessIndex, queue);
        queueMaintainence(queue, nP);
      }
    }
    for (int i = 0; i < nP; i++) {
      turn[i] = turn[i] - arrival[i];
      wait[i] = turn[i] - burst[i];
    }
    calculateOnPresses();
    return [arrival, burst, finish, turn, wait];
  }

  void onNumsSaved(String string) {
    int n = int.parse(string);
    nP = n;
    arrival = List.filled(n, 0);
    burst = List.filled(n, 0);
    wait = List.filled(n, 0);
    turn = List.filled(n, 0);
    finish = List.filled(n, 0);
    queue = List.filled(n, 0);
    tempBurst = List.filled(n, 0);
    complete = List.filled(n, false);
    processed = List.filled(n, false);
    for (int i = 0; i < nP; i++) {
      complete[i] = false;
      queue[i] = 0;
    }
  }

  void intiTimeQuantom(String formTQ) {
    tq = int.parse(formTQ);
  }

  void populateBurst(String n, int index) {
    burst[index] = int.parse(n);
    tempBurst[index] = burst[index];
  }

  void populateArrival(String s, int index) {
    arrival[index] = int.parse(s);
  }

  int checkNewArrival(int timer, List<int> arrival, int n, int maxProcessIndex,
      List<int> queue) {
    if (timer <= arrival[n - 1]) {
      var newArrival = false;
      for (int j = (maxProcessIndex + 1); j < n; j++) {
        if (arrival[j] <= timer && !processed[j] && !queue.contains(j + 1)) {
          // If the process has not been processed yet and is not already in the queue
          maxProcessIndex = j;
          newArrival = true;
          queueUpdating(queue, timer, arrival, n, maxProcessIndex);
        }
      }
      if (!newArrival) {
        // If no new arrival was found, increment the timer
        timer++;
      }
    }
    return timer; // Return the updated timer value
  }

  void queueMaintainence(List<int> queue, int n) {
    for (int i = 0; (i < n - 1) && (queue[i + 1] != 0); i++) {
      // Loop through the processes in the queue until the second last one
      var temp = queue[i]; // Store the current process in a temporary variable
      queue[i] =
          queue[i + 1]; // Move the next process up by one position in the queue
      queue[i + 1] =
          temp; // Move the current process down by one position in the queue
    }
  }

  void queueUpdating(List<int> queue, int timer, List<int> arrival, int n,
      int maxProcessIndex) {
    int zeroIndex =
        queue.indexOf(0); // Find the first empty position in the queue
    if (zeroIndex != -1) {
      // If there is an empty position, add the new process to it
      queue[zeroIndex] = maxProcessIndex + 1;
    } else {
      // If the queue is full, remove the first process in the queue
      queue.removeAt(0);
      // Then add the new process to the end of the queue
      queue.add(maxProcessIndex + 1);
    }
  }

  void calculateOnPresses() {
    avgWait = calculateAverage(wait);
    avgTT = calculateAverage(turn);
  }

  double calculateAverage(List<int> nums) {
    double average =
        nums.reduce((value, element) => value + element) / nums.length;
    return double.parse(average.toStringAsFixed(3));
  }
}
