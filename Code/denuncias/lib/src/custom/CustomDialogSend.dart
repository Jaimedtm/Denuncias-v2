import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDialogSend extends StatefulWidget {
  final bool barrier;
  final Widget body;
  final Widget title;
  final bool fadeInAnimation;
  CustomDialogSend({this.barrier, this.title, this.fadeInAnimation,this.body});

  @override
  _CustomDialogSendState createState() => _CustomDialogSendState();
}

class _CustomDialogSendState extends State<CustomDialogSend>
    with SingleTickerProviderStateMixin {
  bool fadeIn;
  bool barrier;
  Widget title;
  AnimationController controller;
  Animation<double> animation;
  Widget body;

  @override
  void initState() {
    barrier = true;
    title = (widget.title == null) ? Container() : widget.title;
    body = (widget.body == null) ? Container() : widget.body;
    fadeIn = (widget.fadeInAnimation == null) ? false : widget.fadeInAnimation;

    if (fadeIn) {
      controller = AnimationController(
          duration: Duration(milliseconds: 400), vsync: this);
      animation = Tween<double>(begin: 0, end: 1).animate(controller);
      animation.addListener(() {
        setState(() {});
      });

      Future.delayed(Duration(milliseconds: 1)).then((value) {
        controller.forward();
        Future.delayed(Duration(milliseconds: 400)).then((onValue) {
          barrier = (widget.barrier == null) ? false : widget.barrier;
          setState(() {});
        });
      });
    }

    else
      barrier = (widget.barrier == null) ? false : widget.barrier;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bluredScreen(context);
  }

  Widget _bluredScreen(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: GestureDetector(
          onTap: barrier ? () {} : () => Navigator.pop(context),
          child: Container(
            color: Colors.white.withOpacity(0.02),
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Opacity(
                  opacity: fadeIn ? animation.value : 1,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 550,
                        maxWidth: 320,
                        minHeight: 300,
                        minWidth: 300,
                      ),
                      child: Card(
                        color: Colors.white.withOpacity(0.65),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            
                            SizedBox(
                              height: 70,
                              width: double.infinity,
                              child: Container(
                                child: Center(
                                  child: title,
                                ),
                              ),
                            ),

                            Expanded(
                              child: body
                              )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
