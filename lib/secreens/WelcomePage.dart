import 'package:flutter/material.dart';
import 'NoteHomeUi.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double iconSize = screenHeight * 0.15;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: Text(
          'Welcome to the Notes App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
         decoration: BoxDecoration(
          gradient: LinearGradient(

            colors: [Colors.blue, Colors.yellow.shade900],  //// the screan color ////

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note_add_outlined,
                size: iconSize,
                color: Colors.white,
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Welcome to the Notes App',
                style: TextStyle(
                  fontSize: screenHeight * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child: Text(
                  'Take notes, organize your thoughts, and keep track of your ideas with ease.',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.2),
              Center(
                child: SizedBox(
                  height: screenHeight * 0.07,
                  width: screenSize.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NoteHomeUI()),
                      );
                    },
                     child:  Text(
                      'Get Started',
                      style:  TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Code written by Student A, B, and C
      bottomNavigationBar: BottomAppBar(
            child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child:  Text(
            'Code was written by Al-Basara,Al-Nuzaili ,Lamiaa and Mohammed Al-Qureshi',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        color: Colors.white,
        elevation: 0,
      ),
    );
  }
}
