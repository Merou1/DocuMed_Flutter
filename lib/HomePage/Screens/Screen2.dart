import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:documed/Demande/demander.dart';


class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;

  bool _isHoveringDemandez = false;
  bool _isHoveringSuivre = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _heightAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.lightBlueAccent,
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 55, 0, 50),
              padding: EdgeInsets.all(8),
              child: Image(
                image: AssetImage('images/unamed1.png'),
              ),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(width: 0.5, color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Material(
                    elevation: 200.0,
                    borderRadius: BorderRadius.circular(40.0),
                    child: Container(
                      width: screenWidth * 0.95,
                      height: screenHeight * 0.57,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                                child: const Text(
                                  'Démarche A Suivre',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Orelega One',
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DocumentRequestScreen()),

                                );
                              },
                              child:
                              Container(
                                width: 54,
                                height: 56,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/pdf.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),),
                            const SizedBox(height: 20),
                            MouseRegion(
                              onEnter: (event) => setState(() {
                                _isHoveringDemandez = true;
                              }),
                              onExit: (event) => setState(() {
                                _isHoveringDemandez = false;
                              }),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DocumentRequestScreen()),

                                  );
                                },
                                child: Text(
                                  '1-Demandez',
                                  style: TextStyle(
                                    color: Color(0xFF003366),
                                    fontSize: 32,
                                    fontFamily: 'Open Sans Condensed',
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline,

                                    decorationThickness: 2,
                                    decorationColor: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Faites en ligne vos demandes de documents.',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontFamily: 'Open Sans Condensed',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 57.05,
                              height: 56,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/newspaper.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            MouseRegion(
                              onEnter: (event) => setState(() {
                                _isHoveringSuivre = true;
                              }),
                              onExit: (event) => setState(() {
                                _isHoveringSuivre = false;
                              }),
                              child: Text(
                                '2-Suivre',
                                style: TextStyle(
                                  color: Color(0xFF003366),
                                  fontSize: 32,
                                  fontFamily: 'Open Sans Condensed',
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline,

                                  decorationThickness: 2,
                                  decorationColor: Colors.lightBlue,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Suivez l\'état d\'avancement de vos demandes.',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontFamily: 'Open Sans Condensed',
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}