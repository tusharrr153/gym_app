import 'package:flutter/material.dart';
import 'package:gym/pages/home_page.dart';
import 'package:gym/services/services.dart';
import '../common_widget/round_textfield.dart';
import '../common_widget/rounded_button.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String? selectedGender;
  TextEditingController txtDate = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  bool _isLoading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        txtDate.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    String gender = selectedGender ?? "";
    String dob = txtDate.text.trim();
    String weight = weightController.text.trim();
    String height = heightController.text.trim();

    if (gender.isEmpty || dob.isEmpty || weight.isEmpty || height.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
      ));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String res = await AuthServices().completeUserProfile(
      gender: gender,
      dateOfBirth: dob,
      weight: weight,
      height: height,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == "Profile updated successfully") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Image.asset(
                  "assets/image/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Text(
                  "Let's complete your profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                GenderDropdown(
                  hintText: "Choose gender",
                  icon: Icons.person_2_outlined,
                  selectedGender: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hintText: "Date of birth",
                  icon: Icons.calendar_month,
                  controller: txtDate,
                  onTap: () {
                    selectDate(context);
                  },
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RoundTextField(
                        hintText: "Your Weight",
                        icon: Icons.monitor_weight_outlined,
                        controller: weightController,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent.shade100,
                            Colors.blueAccent.shade100
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "KG",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RoundTextField(
                        hintText: "Your Height",
                        icon: Icons.height,
                        controller: heightController,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent.shade100,
                            Colors.blueAccent.shade100
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "CM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : RoundedButton(
                  title: "Save",
                  onPressed: saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: DropdownButton<String>(
              value: selectedGender,
              hint: Text(hintText, style: TextStyle(fontSize: 12)),
              underline: SizedBox(),
              isExpanded: true,
              items: <String>['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 12)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
