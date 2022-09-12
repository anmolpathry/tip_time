import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: completar todo lo necesario
  var costService = TextEditingController();

  var radioGroup = {
    0: "Amazing (20%)", 
    1: "Good (18%)", 
    2: "Okay (15%)"
  };
  int? currentRadio;
  bool isSwitched = false;
  double total = 0.00;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.store, color: Color.fromARGB(255, 0, 107, 4)),
            title: Padding(
              padding: EdgeInsets.only(right: 165),
              child: TextField(
                controller: costService,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cost of Service",
                  errorText: _validate ? 'Value can\'t be Empty' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading:
                Icon(Icons.room_service, color: Color.fromARGB(255, 0, 107, 4)),
            title: Text("How was the service?"),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: radioGroupGenerator(),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(
              Icons.call_made,
              color: Color.fromARGB(255, 0, 107, 4),
            ),
            trailing: Switch(
              activeColor: Colors.blue,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  //print(isSwitched);
                });
              },
            ),
            title: Text("Round up tip?"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 4),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "CALCULATE",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _tipCalculation();
                  setState(() {
                    costService.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                },
                color: Color.fromARGB(255, 0, 107, 4)),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Tip amount: \$ ${total.toStringAsFixed(2)}",
              ),
              SizedBox(width: 8)
            ],
          ),
        ],
      ),
    );
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => Padding(
            padding: const EdgeInsets.only(left: 33),
            child: ListTile(
              leading: Radio(
                activeColor: Colors.blue,
                value: radioElement.key,
                groupValue: currentRadio,
                onChanged: (int? selected) {
                  currentRadio = selected;
                  setState(() {});
                },
              ),
              title: Transform.translate(
                offset: Offset(-16, 0),
                child: Text("${radioElement.value}"),
              ),
            ),
          ),
        )
        .toList();
  }

  double _tipCalculation() {
    // TODO: completar

    if (costService.text.isEmpty) {
      total = 0.00;
    } else {
      total = double.parse(costService.text);
      if (currentRadio == 0) {
        total *= 1.20;
      } else if (currentRadio == 1) {
        total *= 1.18;
      } else if (currentRadio == 2) {
        total *= 1.15;
      }

      if (isSwitched) {
        total = total.ceilToDouble();
      } 
    }
    return total;
  }
}
