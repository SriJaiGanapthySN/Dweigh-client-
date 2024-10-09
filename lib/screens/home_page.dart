import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dweigh/constants/image_url.dart';
import 'package:dweigh/screens/welcome_screen.dart';
import 'package:dweigh/services/auth/auth_service.dart';
import 'package:dweigh/widgets/form_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Images _images = Images();

  void logout(BuildContext context) async {
    //get auth
    final authservice = AuthService();
    //signout
    try {
      // Show a loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF034C8D),
            ),
          );
        },
      );
      await authservice.signOut();
      //popping it
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        automaticallyImplyLeading: false,
        title: Text(
          'Book Service Of Your Choice',
          style: GoogleFonts.emblemaOne(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF034C8D),
          ),
          maxLines: 2,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            onPressed: () => logout(context),
          )
        ],
        backgroundColor: const Color(0xFFAAD7E2),
      ),
      backgroundColor: const Color(0xFFD0F8F5),
      body: Container(
        margin: EdgeInsets.only(top: height * 0.005),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // navigation from wigh bridge to form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormWidget(
                        asset: _images.truck,
                        service: "WEIGH BRIDGE",
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.asset(
                      _images.truck,
                      height: height * 0.23,
                      width: width * 0.75,
                    ),
                    Text(
                      "WEIGH BRIDGE",
                      style: GoogleFonts.belanosima(
                        fontSize: 32,
                        color: const Color(0xFF034C8D),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  // navigation from weigh scale to form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormWidget(
                        asset: _images.weigh,
                        service: "WEIGHING SCALE",
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.asset(
                      _images.weigh,
                      height: height * 0.22,
                    ),
                    SizedBox(
                      height: height * 0.001,
                    ),
                    Text(
                      "WEIGHING SCALE",
                      style: GoogleFonts.belanosima(
                        fontSize: 32,
                        color: const Color(0xFF034C8D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
