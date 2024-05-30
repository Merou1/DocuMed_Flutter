import 'package:flutter/material.dart';
import 'package:documed/Login/SignIn.dart';



class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: _IntroPage(),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(color: Color(0xFF181FC7)),
      child: Stack(
        children: [
          Positioned(
            height: 300,
            right: 14,
            left: 4,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'images/unamed1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.35,
            top: screenWidth * 0.9,
            child: Image.asset(
              'images/UniChat.png',
              width: 150,
            ),
          ),
          Positioned(
            left: screenWidth * 0.1,
            top: screenHeight * 0.56,
            right: screenWidth * 0.1,
            child: SizedBox(
              height: screenHeight * 0.15,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'UniChat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Adjusted size
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.1,
            top: screenHeight * 0.78,
            right: screenWidth * 0.1,
            child: SizedBox(
              child: Text(
                'The best School platform for Schools who cares about their student’s success',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.2,
            top: screenHeight * 0.9,
            right: screenWidth * 0.2,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(20),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
