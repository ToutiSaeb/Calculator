import 'dart:ffi';

import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';



class homepage extends StatefulWidget {

  
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int i=btn.buttonValues.length;
  
   String num1="";
  String num2="";
  String operand="";


  
 
 
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          
                 Expanded(
                  flex: 1,
                  child: Container(
                  color: Colors.grey[700],
                 margin: EdgeInsets.only(bottom: 30,top: 10),
                 padding: EdgeInsets.only(bottom: 2,),
                 
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: [
                     Expanded(
                      flex: 4,
                      child:     Row(
                        children: [
                           Text(" Liva",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    
                  ),
                  textAlign:TextAlign.end,
                  ),
                   Text("Calculator",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                    
                  ),
                  textAlign:TextAlign.end,
                  ),
                        ],
                      ),),
                     Expanded(
                      flex: 2,
                      child:  Text(
                        "$num1$operand$num2".isEmpty?"0":"$num1$operand$num2",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  textAlign:TextAlign.end,
                  ),)
                    ],
                  )
                )),
             
           
         Expanded(
          flex: 2,
          child: Container(
            child: GridView.builder(
            
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 10,crossAxisSpacing: 10),
              physics: NeverScrollableScrollPhysics(),
              itemCount: i,
             itemBuilder: (context,i){
             return buildButton(btn.buttonValues[i]);

            
             },
             ),
          )
           
         ),
           
          ],
        )
        ),
    );
  }
  Widget buildButton(value) {
    return  Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: ()=> tape(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      );
    
  }
    Color getBtnColor(value) {
    return [btn.del, btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            btn.per,
            btn.multiply,
            btn.add,
            btn.subtract,
            btn.divide,
            btn.calculate,
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
void tape(String value){
    switch(value){
      case btn.del: del();
      case btn.clr: clear();
      case btn.calculate: cal();
      default:ajout(value);

    }
    
    setState(() {
      
    });

}
  /////////////
del(){
   if(num2.isNotEmpty){
    num2=num2.substring(0,num2.length-1);

  }
  
  else if(operand.isNotEmpty){
    operand=operand.substring(0,operand.length-1);

  }
   else if(num1.isNotEmpty){
    num1=num1.substring(0,num1.length-1);

  }
  setState(() {
    
  });
  
}
clear(){
  num1="";
  num2="";
  operand="";
  setState(() {
    
  });

}


ajout( String value){
if( value != null){
  if(this.num1.isNotEmpty&&this.num2.isNotEmpty){
   
    this.operand=value;

  }
   else if (this.num1.isEmpty || operand.isEmpty) {  

      if (value == btn.dot && (this.num1.isEmpty || this.num1 == btn.n0)) {
        value = "0.";
      }
      this.num1 += value;
    }
    
    else if (this.num2.isEmpty || operand.isNotEmpty) {
      
      if (value == btn.dot && (this.num2.isEmpty || this.num2 == btn.n0)) {

        value = "0.";
      }
      this.num2 += value;
}
}

setState(() {
  
});


}
cal(){ 
  try{
Parser p=new Parser();
Expression exp=p.parse(this.num1+this.operand+this.num2);
String result=exp.evaluate(EvaluationType.REAL,ContextModel()).toString();
if(result.substring(result.length-2,result.length)==".0"){
  this.num1=result.substring(0,result.length-2);
}
else{
this.num1=result;
}
  }
  catch(e){
    this.num1="LivaException:  error";
  }
  


  setState(() {
  });



}

  


}


