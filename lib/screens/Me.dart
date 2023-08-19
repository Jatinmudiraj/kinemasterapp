import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Me extends StatelessWidget {
  const Me({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "KindMaster",
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Connect with global video creators",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              height: 50,
              width: 300,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.red[700],
                onPressed: () {},
                label: const Text('Create an Account'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "OR",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {},
                label: Row(
                  children: [
                    // Image(image: AssetImage('assets/google.png'), width: 30,height: 30,),
                    Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red[700],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 300,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {},
                label: Row(
                  children: [
                    // Image(image: AssetImage('assets/mac.png'), width: 30,height: 30,),
                    Icon(
                      FontAwesomeIcons.apple,
                      color: Colors.red[700],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Continue with Apple',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'I have read and accept the Kinemaster',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Terms of services and privacy policy clicked.");
              },
              child: const Text(
                'Terms of Service and Privacy Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                GestureDetector(
                    onTap: () {
                      print("signed in with google clicked.");
                    },
                    child: const Text(
                      "Sign in with email",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
