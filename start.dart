import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:pract_app/login.dart';
// import 'package:pract_app/signin.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset("assets/images/img.png"),
              Text(
                "Hey! Welcome",
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSlab(
                    fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Second');
                },
                child: const Text("Get Started"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: StadiumBorder()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Third');
                },
                child: Text("Already have a account"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: StadiumBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
