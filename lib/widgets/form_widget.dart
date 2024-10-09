import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dweigh/constants/image_url.dart';
import 'package:dweigh/services/complaints/complaint_service.dart';
import 'package:dweigh/widgets/done_widget.dart';
import 'package:dweigh/widgets/my_button.dart';
import 'package:dweigh/widgets/my_textfield.dart';

class FormWidget extends StatelessWidget {
  FormWidget({
    super.key,
    required this.asset,
    required this.service,
    required this.height,
    required this.width,
  });

  final Images _images = Images();

  //instances
  final ComplaintService _complaintService = ComplaintService();

  //controllers
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _brandcontroller = TextEditingController();
  final TextEditingController _complaintcontroller = TextEditingController();

  final String asset;
  final String service;
  final double height;
  final double width;

  //register complaints

  void sendcomplaints(BuildContext context, String type) async {
    //validate the fields
    if (_namecontroller.text.isEmpty ||
        _phonecontroller.text.isEmpty ||
        _phonecontroller.text.length != 10 ||
        _brandcontroller.text.isEmpty ||
        _complaintcontroller.text.isEmpty) {
      //show dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Please Check The Details"),
          content: _phonecontroller.text.isEmpty
              ? const Text("Enter All The Fields")
              : const Text("Check The Mobile Number Entered"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

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

    // Send complaints to the server
    await _complaintService.createComplaint(
        _namecontroller.text,
        _phonecontroller.text,
        type,
        _brandcontroller.text,
        _complaintcontroller.text);

    // Hide the loading dialog
    Navigator.pop(context);

    //show success dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DoneWidget(
          asset: type == "WEIGH BRIDGE" ? _images.truck : _images.weigh,
          height: 400,
          width: 400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'SERVICE BOOKING',
          style: GoogleFonts.emblemaOne(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF034C8D),
          ),
          maxLines: 2,
        ),
        backgroundColor: const Color(0xFFAAD7E2),
      ),
      backgroundColor: const Color(0xFFD0F8F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    asset,
                    height: height,
                    width: width,
                  ),
                  Text(
                    service,
                    style: GoogleFonts.belanosima(
                      fontSize: 32,
                      color: const Color(0xFF034C8D),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                      hinttext: "Name",
                      obscure: false,
                      controller: _namecontroller),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                      hinttext: "Phone Number",
                      obscure: false,
                      type: TextInputType.number,
                      controller: _phonecontroller),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                      hinttext: "Brand",
                      obscure: false,
                      controller: _brandcontroller),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                      hinttext: "Complaint",
                      obscure: false,
                      type: TextInputType.multiline,
                      controller: _complaintcontroller),
                  const SizedBox(
                    height: 40,
                  ),
                  MyButton(
                      text: "Submit",
                      onTap: () {
                        sendcomplaints(context, service);
                      },
                      size: 26)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
