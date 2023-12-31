import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/Student.dart';
import '../Custom widgets/loading.dart';
import '../Providers/UserProvider.dart';
import 'SignUp2.dart';
// import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameCont = TextEditingController();
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var hidePass = true;
  var passIcons = const Icon(Icons.visibility_off);
  bool loading = false;
  // final GlobalKey<FlutterPwValidatorState> validatorKey =
  //     GlobalKey<FlutterPwValidatorState>();

  // Valid email domains
  final List<String> allowedDomains = ['gmail.com', 'hotmail.com', 'yahoo.com'];

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a password';
    }

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      String error = '';

      if (value.length < 8) {
        error += 'Password must be at least 8 characters long. ';
      } else if (!value.contains(RegExp(r'[A-Z]'))) {
        error += 'Password must contain at least one uppercase letter. ';
      } else if (!value.contains(RegExp(r'\d'))) {
        error += 'Password must contain at least one digit.';
      }

      return error.trim(); // Return the combined error message
    }

    return null; // Return null if the password is valid
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a Name';
    }

    // Regular expression to match alphabetic characters only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');

    if (!nameRegExp.hasMatch(value)) {
      return 'Name can only contain letters';
    }

    return null; // Return null if the name is valid
  }

  // Custom email validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter an E-mail';
    }

    final emailParts = value.split('@');
    if (emailParts.length != 2 || !allowedDomains.contains(emailParts[1])) {
      return 'Enter a valid email address';
    }

    return null; // Return null if the email is valid
  }

  bool isValidEmail(String email) {
    String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';
    return RegExp(emailRegex).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading() // Using your custom Loading widget
        : Scaffold(
            appBar: AppBar(
              title: const Text("Sign Up"),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: TextFormField(
                        validator: validateName,
                        controller: nameCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Enter your name',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: Text(
                        "E-mail",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: TextFormField(
                        validator: validateEmail,
                        controller: emailCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Enter your e-mail',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: TextFormField(
                        validator: validatePassword,
                        obscureText: hidePass,
                        controller: passCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              hidePass = !hidePass;
                              passIcons = hidePass
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility);
                              setState(() {});
                            },
                            icon: passIcons,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: MaterialButton(
                            onPressed: () {
                              //TODO: add sign up logic
                              String email = emailCont.text;
                              String password = passCont.text;
                              String name = nameCont.text;

                              // Check email criteria
                              if (!isValidEmail(email)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Error: Please enter a valid email address.",
                                    ),
                                  ),
                                );
                                return;
                              }
                              // Check email criteria
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Error: name can't be empty.",
                                    ),
                                  ),
                                );
                                return;
                              }

                              // Check password criteria
                              final passwordRegExp =
                                  RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');

                              if (!passwordRegExp.hasMatch(password)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Error: Password must meet the following criteria:\n"
                                      "- At least one uppercase letter\n"
                                      "- At least one digit\n"
                                      "- Minimum length of 8 characters",
                                    ),
                                  ),
                                );
                                return;
                              }

                              Student currentUser = Student(
                                name: name,
                                email: email,
                                password: password, ID: '', age: 0, phonenum: '', year: '', college: '',
                                  major: '', university: ''
                              );
                              currentUser.ID = currentUser.generateNextID();
                              context.read<UserProvider>().setCurrentUser(currentUser);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp2()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ... rest of the UI remains unchanged
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Container(
                    //           margin: const EdgeInsets.only(right: 8.0),
                    //           height: 1.0, // Adjust the height as needed
                    //           color: Colors.grey[600], // Color of the dashes
                    //         ),
                    //       ),
                    //       Text(
                    //         "or",
                    //         style: TextStyle(
                    //           color: Colors.grey[800],
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           margin: const EdgeInsets.only(left: 8.0),
                    //           height: 1.0, // Adjust the height as needed
                    //           color: Colors.grey[600], // Color of the dashes
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Center(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Container(
                    //       padding: const EdgeInsets.all(8.0),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: Colors.grey.shade300, // Border color
                    //             width: 2.0, // Border width
                    //           ),
                    //           borderRadius: BorderRadius.circular(12.0)),
                    // child: MaterialButton(
                    //   onPressed: () async {
                    //     setState(() => loading = true);
                    //     // Add your Google Sign-Up logic here
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         width: 50.0,
                    //         height: 50.0,
                    //         // padding: EdgeInsets.all(10.0),
                    //         alignment: Alignment.center,
                    //         child:
                    //             Image.asset("assets/images/google.png"),
                    //       ),
                    //       const Text(
                    //         "Register with Google",
                    //         style: TextStyle(fontSize: 18),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already signed up ?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the login page
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    emailCont.dispose();
    passCont.dispose();
    nameCont.dispose();
    super.dispose();
  }
}
