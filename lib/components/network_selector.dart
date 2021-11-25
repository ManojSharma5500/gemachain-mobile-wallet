import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const options = [
  'Mainnet-beta (default)',
  'Devnet',
  'Testnet',
  'Custom',
];

const urlOptions = {
  'Mainnet-beta (default)': 'http://99.20.20.233:8899',
  'Devnet': 'http://99.20.20.233:8899',
  'Testnet': 'http://99.20.20.233:8899',
  'Custom': '',
};

class NetworkSelector extends StatefulWidget {
  Function onSelected;

  NetworkSelector(this.onSelected);

  @override
  State<StatefulWidget> createState() {
    return new NetworkSelectorState(onSelected);
  }
}

class NetworkSelectorState extends State<NetworkSelector> {
  String selectedOption = "Mainnet-beta (default)";
  String customNetworkURL = "";
  Function onSelected;

  NetworkSelectorState(this.onSelected);

  @override
  Widget build(BuildContext context) {
    onSelected(urlOptions[selectedOption]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: DropdownButton<String>(
            value: selectedOption,
            iconSize: 24,
            elevation: 16,
            isDense: true,
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
                if (selectedOption != 'Custom') {
                  onSelected(urlOptions[selectedOption]);
                }
              });
            },
            items: options.map<DropdownMenuItem<String>>(
              (String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              },
            ).toList(),
          ),
        ),
        if (selectedOption == 'Custom') ...[
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Empty URL';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: 'Enter a custom netwok URL',
              ),
              onChanged: (String value) async {
                customNetworkURL = value;
                onSelected(customNetworkURL);
              },
            ),
          ),
        ]
      ],
    );
  }
}
