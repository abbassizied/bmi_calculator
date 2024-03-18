import 'package:flutter/material.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color myColor = Colors.transparent;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiCategory = "";

  RegExp digitValidator = RegExp("[0-9]+");
  bool isHeightANumber = true;
  bool isWeightANumber = true;

  void setHeightValidator(valid) {
    setState(() {
      isHeightANumber = valid;
    });
  }

  void setWeightValidator(valid) {
    setState(() {
      isWeightANumber = valid;
    });
  }

// The calculateBMI function calculates the BMI based on the provided weight (weight) and height (height) as arguments.
  void calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double bmi = weight / (height * height);
    // We use setState() to update the state and reflect the new value of bmiResult.
    setState(() {
      determineCategory(bmi);
      bmiResult = bmi;
      if (bmiResult < 18.5) {
        myColor = const Color(0xFF87B1D9);
      } else if (bmiResult >= 18.5 && bmiResult <= 24.9) {
        myColor = const Color(0xFF3DD365);
      } else if (bmiResult >= 25 && bmiResult <= 29.9) {
        myColor = const Color(0xFFEEE133);
      } else if (bmiResult >= 30 && bmiResult <= 34.9) {
        myColor = const Color(0xFFFD802E);
      } else if (bmiResult >= 35) {
        myColor = const Color(0xFFF95353);
      }
    });
  }

// The clearResult function resets the height and weight input fields and clears the BMI result.
  void clearResult() {
    setState(() {
      bmiResult = 0.0;
      heightController.clear();
      weightController.clear();
    });
  }

  // The determineCategory function takes the BMI result as an argument and returns the corresponding category based on predefined ranges.
  void determineCategory(double bmiRes) {
    setState(() {
      if (bmiRes < 1) {
        bmiCategory = '';
      } else if (bmiRes < 18.5) {
        bmiCategory =
            'Your BMI is Underweight, which is considered underweight. You may want to consult a healthcare professional for advice on healthy weight gain.';
      } else if (bmiRes <= 24.9) {
        bmiCategory =
            'Great news! Your BMI is Normal Weight, indicating a healthy weight range.';
      } else if (bmiRes <= 29.9) {
        bmiCategory =
            'Your BMI is Overweight, which falls into the overweight category. Talking to a healthcare professional can help you develop a safe and effective plan for reaching a healthy weight.';
      } else if (bmiRes <= 34.9) {
        bmiCategory =
            'Your BMI is Obesity Class I, which is considered obese. It\'s important to consult a healthcare professional to discuss healthy weight management strategies tailored to your needs.';
      } else if (bmiRes <= 39.9) {
        bmiCategory =
            'A BMI of Obesity Class II falls within the obese range. Consulting a healthcare professional can help you create a safe and effective plan for weight management.';
      } else {
        bmiCategory =
            'A BMI of Obesity Class III falls within the obese range. Consulting a healthcare professional can help you create a safe and effective plan for weight management.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.speed),
              Text(
                'BMI Calculator',
                style: TextStyle(
                  color: Colors.black, // set the color of the title text
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              // Input fields and buttons
              TextField(
                controller: heightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLength: 6,
                onChanged: (inputValue) {
                  if (inputValue.isEmpty ||
                      digitValidator.hasMatch(inputValue)) {
                    setHeightValidator(true);
                  } else {
                    setHeightValidator(false);
                  }
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your height in m',
                    errorText: isHeightANumber ? null : "Please enter a number",
                    errorStyle: const TextStyle(color: Colors.purpleAccent),
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent)),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLength: 6,
                onChanged: (inputValue) {
                  if (inputValue.isEmpty ||
                      digitValidator.hasMatch(inputValue)) {
                    setWeightValidator(true);
                  } else {
                    setWeightValidator(false);
                  }
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your weight (kg)',
                    errorText: isWeightANumber ? null : "Please enter a number",
                    errorStyle: const TextStyle(color: Colors.purpleAccent),
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent)),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent))),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  calculateBMI();
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    isScrollControlled: true,
                    constraints: BoxConstraints.tight(Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * .8)),
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            //--------------------------------------------------
                            Center(
                              child: Container(
                                width: 300,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: myColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: Center(
                                    child: Text(
                                  "Your BMI is : ${bmiResult.toStringAsFixed(3)}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              bmiCategory,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .black, // set the color of the title text
                              ),
                            )),
                            //--------------------------------------------------
                            const SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF87B1D9),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                      ),
                                      const Text(
                                        "Underweight",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF3DD365),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                      ),
                                      const Text(
                                        "Normal",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFEEE133),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                      ),
                                      const Text(
                                        "Overweight",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFD802E),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                      ),
                                      const Text(
                                        "obese",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF95353),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                      ),
                                      const Text(
                                        "Extreme",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Calculate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
