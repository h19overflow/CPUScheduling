import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalInputs extends StatelessWidget {
  const HorizontalInputs(
      {super.key,
      required this.formKey,
      required this.isQuantum,
      required this.numOfProcessController,
      required this.timeQuantumController,
      required this.numOfProcessFunction,
      required this.timeQuantumFunction});

  final bool isQuantum;
  final TextEditingController numOfProcessController;
  final TextEditingController timeQuantumController;
  final void Function(String) numOfProcessFunction;
  final void Function(String) timeQuantumFunction;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 2, 8, 37),
                  Color.fromARGB(255, 18, 28, 101),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 10)
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(left: isQuantum ? 42 : 125),
                          child: const Text(
                            'Enter Number of process',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),
                    ),
                    if (isQuantum)
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: const Text(
                          "Enter time quantum",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white),
                      width: 130,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: numOfProcessController,
                        onSaved: (newValue) {
                          numOfProcessFunction;
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Complete This Field ';
                          } else if (value.isEmpty) {
                            return 'Please Enter A value';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a number';
                          } else if (int.parse(value) <= 0) {
                            return 'Values Higher than 0 ';
                          }
                        },
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          hintText: 'Number of Process',
                        ),
                      ),
                    ),
                    if (isQuantum)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            color: CupertinoColors.white),
                        width: 135,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          controller: timeQuantumController,
                          onSaved: (newValue) {
                            timeQuantumFunction;
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null) {
                              return 'Please Complete This Field ';
                            } else if (value.isEmpty) {
                              return 'Please Enter A value';
                            } else if (int.tryParse(value) == null) {
                              return 'Please enter a number';
                            } else if (int.parse(value) <= 0) {
                              return 'Values Higher than 0 ';
                            }
                          },
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              hintText: 'Time Quantum',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
