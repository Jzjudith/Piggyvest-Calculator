import "package:flutter/material.dart";
import "dart:math";


void main() => runApp(
  MaterialApp(
    title: 'Piggy Calculator',
    theme: ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.blue,
    ),

    home: HomeScreen()
  )
);

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen> {

  List _monthsInYears = [ 'Month(s)', 'Year(s)' ];
  String _monthsInYear = "Year(s)";
  String _compoundedInterest = "";

  final TextEditingController _paymentPerMonth = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _timeInYears = TextEditingController();

  bool _switchValue = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piggyvest Calculator"),
        elevation: 0.0
      ),

      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _paymentPerMonth,
                  decoration: InputDecoration(
                    labelText: "Enter Payment per month"
                  ),
                  keyboardType: TextInputType.number,

                )
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _interestRate,
                  decoration: InputDecoration(
                    labelText: "Annual Interest Rate"
                  ),
                  keyboardType: TextInputType.number,
                )
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: _timeInYears,
                        decoration: InputDecoration(
                          labelText: "Number Of Years"
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            'Time In Years',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Switch(
                            value: _switchValue,
                            onChanged: (bool value) {
                              print(value);
                              if( value ) {
                                _monthsInYear = _monthsInYears[1];
                              } else {
                                _monthsInYear = _monthsInYears[0];
                              }
                              setState(() {
                                _switchValue = value;
                              });
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: FlatButton(
                  child: Text("Calculate"),
                    onPressed: () {
                    _handleCalculation (); },
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _handleCalculation() {

    //  Compounded Interest
    //  F = P * (((1 + r/n)nt - 1) / (r/n))
    //  F = Future value
    //  P = Payment per month
    //  r = Annual interest rate
    //  n = total number of payments or periods

    double F = 0.0;
    int P = int.parse(_paymentPerMonth.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int t = int.parse(_timeInYears.text);
    int n = _monthsInYear == "Year(s)" ? int.parse(_timeInYears.text) * 12  : int.parse(_timeInYears.text);

    F = P * ((pow((1 + r/n), n*t) - 1) / (r/n));

    _compoundedInterest = F.toStringAsFixed(2);
    setState(() {

    });
  }

 Widget compoundedInterest(compoundedInterest) {
    bool canShow = false;
    String _compoundedInterest = compoundedInterest;

    if( _compoundedInterest.length > 0 ) {
      canShow = true;
    }
    return
    Container(
      margin: EdgeInsets.only(top: 40.0),
      child: canShow ? Column(
        children: [
          Text("Your compounded Interest is",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            )
          ),
          Container(
            child: Text(_compoundedInterest,
              style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ) : Container()
    );
  }
}
