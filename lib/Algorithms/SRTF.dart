class SRTF {
  int nP = 0;
  List<int> arrivalTime = [];
  List<int> burstTime = [];
  List<int> tempBurstTime = [];
  List<int> waitingTime = [];
  List<int> turnaroundTime = [];
  List<int> completionTime = [];
  double avgWait = 0;
  double avgTurn = 0;
  List<int> startTimes = [];
  List<int> finishTimes = [];
  List<List<int>> timeSlices = [];

  List<Map<String, dynamic>> processDetails =
      []; // New list to store time slices

  void srtfAlgo() {
    timeSlices.clear();
    print('SRTF STARTED!!!');
    burstTime[nP] = 9999; // Assuming nP is the number of processes
    int smallest, count = 0, time;
    double end;
    int prevProcess = -1;
    int startTime = 0;

    for (time = 0; count != nP; time++) {
      smallest = nP;
      for (int i = 0; i < nP; i++) {
        if (arrivalTime[i] <= time &&
            burstTime[i] < burstTime[smallest] &&
            burstTime[i] > 0) {
          smallest = i;
        }
      }

      // Process change handling
      if (prevProcess != smallest) {
        if (prevProcess != -1) {
          // Record the time slice for the previous process
          timeSlices.add([prevProcess + 1, startTime, time]);
        }
        // Update the start time for the new process
        startTime = time;
      }
      prevProcess = smallest;

      // Process execution
      if (smallest != nP) {
        burstTime[smallest]--;
      }

      // Process completion
      if (burstTime[smallest] == 0) {
        count++;
        end = time + 1;
        completionTime[smallest] = end.toInt();
        waitingTime[smallest] = completionTime[smallest] -
            arrivalTime[smallest] -
            tempBurstTime[smallest];
        turnaroundTime[smallest] =
            completionTime[smallest] - arrivalTime[smallest];

        // Record the time slice for the completed process
        timeSlices.add([smallest + 1, startTime, time + 1]);
        prevProcess = -1;
      }

      // Populate processDetails here
      processDetails = List.generate(
          nP,
          (index) => {
                "Process": "P${index + 1}",
                "Burst Time": tempBurstTime[index],
                "Arrival Time": arrivalTime[index],
                "Waiting Time": waitingTime[index],
                "Turnaround Time": turnaroundTime[index],
                "Completion Time": completionTime[index]
              });

      // Sort the list of maps based on arrival time
      processDetails
          .sort((a, b) => a["Arrival Time"].compareTo(b["Arrival Time"]));
    }
    calculateOnPresses();
    reassignValues();
    print(timeSlices);
  }

  void reassignValues() {
    for (var i = 0; i < nP; i++) {
      tempBurstTime[i] = processDetails[i]["Burst Time"];
      arrivalTime[i] = processDetails[i]["Arrival Time"];
      waitingTime[i] = processDetails[i]["Waiting Time"];
      turnaroundTime[i] = processDetails[i]["Turnaround Time"];
      completionTime[i] = processDetails[i]["Completion Time"];
    }
  }

  void onNumsSaved(String string) {
    nP = int.parse(string);
    arrivalTime = List.filled(nP, 0);
    tempBurstTime = List.filled(nP, 0);
    burstTime = List.filled(nP + 1, 0);
    waitingTime = List.filled(nP, 0);
    turnaroundTime = List.filled(nP, 0);
    completionTime = List.filled(nP, 0);
  }

  void populateBurst(String n, int index) {
    burstTime[index] = int.parse(n);
    tempBurstTime[index] = burstTime[index]; // Copy the value to tempBurstTime
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
}
