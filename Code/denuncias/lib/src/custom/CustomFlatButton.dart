import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';


class CustomFlatButton extends StatefulWidget {

  final int white=0;
  final int blue=1;
  final int green=2;

  final Function onPress;
  final int color;
  final String text;
  final double fontSize;

  CustomFlatButton({@required this.onPress,this.color,this.text,this.fontSize});
  //FlatButton({Key key}) : super(key: key);

  @override
  _FlatBeatyButton createState() => _FlatBeatyButton();

}

class _FlatBeatyButton extends State<CustomFlatButton> with SingleTickerProviderStateMixin {

  Color borderColor;
  Color textColor1, textColor2;
  Color infillColor;
  int   alpha;
  bool  enable;

  Animation <double> infilAnimation;
  AnimationController controller1;
  Color txtColor;

  

  @override
  void initState() {

    switch (widget.color) {

      case 0:

        borderColor = Colors.white;
        textColor1 = Colors.white;
        textColor2 = backgroundColor;
        infillColor = Colors.white;
        
        break;

      case 1:

        borderColor = blueButton;
        textColor1 = blueButton;
        textColor2 = backgroundColor;
        infillColor = blueButton;
      
      break;

      case 2:

        borderColor = greenButton;
        textColor1 = greenButton;
        textColor2 = backgroundColor;
        infillColor = greenButton;
      
      break;

      case 4:

        borderColor = backgroundColor;
        textColor1 = backgroundColor;
        textColor2 = textColor;
        infillColor = backgroundColor;
      
      break;

      default:
        borderColor = Colors.white;
        textColor1 = Colors.white;
        textColor2 = backgroundColor;
        infillColor = Colors.white;
    }

    txtColor=textColor1;

    
    super.initState();

    controller1=AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    infilAnimation= Tween<double> (begin: 0, end: 1).animate(controller1)
    ..addListener((){
      setState(() {
        
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

        onTapUp: (TapUpDetails tapUpDetails){
          widget.onPress();
          controller1.reverse();
          txtColor=textColor1;

        },

        onTapDown:  (TapDownDetails tapDownDetails){
          controller1.forward();
          txtColor=textColor2;
        },

        onTapCancel: (){
          controller1.reverse();
          txtColor=textColor1;
        },

        child: Center(

          child: SizedBox (

            height: double.infinity,
            width: double.infinity,

            child: Container(
              
              child: Center(

                child: Container(

                  child: Stack(
                    children: <Widget>[

                      Center(
                        child: Container(

                          child: FractionallySizedBox(

                            heightFactor: infilAnimation.value,
                            widthFactor: infilAnimation.value,

                          ),

                          decoration: BoxDecoration(
                            color: infillColor,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),

                        ),
                      ),

                      Center(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: ((widget.fontSize==null) ? 30 : widget.fontSize),
                            fontWeight: FontWeight.w300,
                            color: txtColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(3),

                ),
              ),

              decoration: BoxDecoration(
                
                border: Border.all(

                  width: 2,
                  color: borderColor

                ),

                borderRadius: BorderRadius.all(Radius.circular(20)),

              ),

            ),

          ),

        )
    );

  }

}