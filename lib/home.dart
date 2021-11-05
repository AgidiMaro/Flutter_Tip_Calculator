
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy/util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
 int tt = 0;
  int _tipPercentage =0;
  int _personCounter =1;
  double _billAmount = 0.0;

  Color _purple = HexColor ("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height:150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total per person", style:TextStyle(fontWeight: FontWeight.normal,color: _purple, fontSize: 15) ,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 34.9,color: _purple),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                  borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                      onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }
                      catch(exception){
                        _billAmount = 0.0;

                      }
                      }

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split", style: TextStyle(color: Colors.grey.shade700),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap:(){
                              setState(() {
                                if(_personCounter>1){
                                  _personCounter--;
                                }
                                else{}

                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),

                              ) ,
                              child: Center(child: Text("-",style: TextStyle(color: _purple, fontWeight: FontWeight.bold,fontSize: 17.8),)),
                            ),
                          ),
                          Text("$_personCounter",style: TextStyle(color: _purple, fontWeight: FontWeight.bold,fontSize: 17.8),),
                          InkWell(
                            onTap:(){
                              setState(() {
                                  _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),
                              ) ,
                              child: Center(child: Text("+",style: TextStyle(color: _purple, fontWeight: FontWeight.bold,fontSize: 17.8),)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip", style: TextStyle(color: Colors.grey.shade700),),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$${(calculateTip(_tipPercentage, _billAmount)).toStringAsFixed(2)}", style: TextStyle(color: _purple,fontSize: 17, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  //slider
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%",style: TextStyle(color: _purple,fontSize: 17, fontWeight: FontWeight.bold),),
                      Slider(
                          min:0,
                          max:100,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged:(double value){
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          },
                          activeColor:_purple,
                        inactiveColor: Colors.grey,

                      )
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      )


    );
  }
  double calculateTip(int tipPercentage, double billAmount){
    double tip = 0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null){
    }
    else{
      tip = billAmount*tipPercentage/100;
    }
    return tip;
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){
    var totalPerPerson = (billAmount+calculateTip(tipPercentage, billAmount))/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

}
