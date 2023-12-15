import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ProcessInputs extends StatefulWidget {
  int index;
  final GlobalKey<FormState> burstFormKey;
  final String inputHint;
  final String? Function(String?) validatorFunction;

  ProcessInputs(
      {required this.validatorFunction,
      required this.index,
      required this.inputHint,
      required this.burstFormKey,
      required this.populateFunction});

  final void Function(String?) populateFunction;

  @override
  State<ProcessInputs> createState() => _ProcessInputsState();
}

class _ProcessInputsState extends State<ProcessInputs> {
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35, left: 20),
            child: Text(
              'P${widget.index}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(208, 35, 43, 110),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 10)
                ]),
            margin:
                const EdgeInsets.only(left: 5, top: 15, bottom: 10, right: 5),
            height: 50,
            width: 100,
            child: TextFormField(
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              validator: widget.validatorFunction,
              onSaved: widget.populateFunction,
              decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                border: InputBorder.none,
                hintText: widget.inputHint,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
