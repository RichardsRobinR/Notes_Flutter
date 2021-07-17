
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/logic.dart';
import 'package:login_demo/logicv2.dart';
import 'package:login_demo/screens/notes.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textcontroller = TextEditingController();
  TextEditingController _passwordtextcontroller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  void nativeGoogleSignIn() async {
    await  context.read<LogicV2>().signInWithGoogle();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notes()));
  }

  void webGoogleSignIn() async {
    await  context.read<LogicV2>().websignInWithGoogle();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notes()));
  }

  void emailSignIn() async {
    await  context.read<LogicV2>().signIn(email: _textcontroller.text, password: _passwordtextcontroller.text);

    if(_textcontroller.text.isNotEmpty && _passwordtextcontroller.text.isNotEmpty && context.read<LogicV2>().isTrue == true ) {
      context.read<LogicV2>().isTrue = false;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notes()));

    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
          //color: Colors.blueGrey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Notes .',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 70,
                    ),),
                  SizedBox(height: 20),

                  OutlinedButton(
                      style: ButtonStyle(
                        //backgroundColor: MaterialStateProperty.all(Colors.red),
                        minimumSize:
                        MaterialStateProperty.all(Size.fromHeight(50)),
                      ),
                      onPressed: nativeGoogleSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/google.png',fit: BoxFit.scaleDown,width: 25,height: 25,),
                          SizedBox(width: 20),
                          Text(
                            "Sign In With Google",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              // color: Colors.white,
                            ),
                          ),
                        ],
                      )),

                  // Container(
                  //   //width: 350,
                  //   height: 500,
                  //
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 3, color: Colors.white70),
                  //       color: Colors.white60,
                  //       //color: Colors.green,
                  //       borderRadius: BorderRadius.circular(20)),
                  //   padding: EdgeInsets.all(16),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                        // TextFormField(
                        //   controller: _textcontroller,
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter the Email',
                        //     labelText: 'Email',
                        //
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // SizedBox(height: 20),
                        // TextFormField(
                        //   controller: _passwordtextcontroller,
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter the Password',
                        //     labelText: 'Password',
                        //
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // SizedBox(height: 20),
                        // OutlinedButton(
                        //     style: ButtonStyle(
                        //       //backgroundColor: MaterialStateProperty.all(Colors.red),
                        //       minimumSize:
                        //       MaterialStateProperty.all(Size.fromHeight(50)),
                        //     ),
                        //     onPressed: emailSignIn,
                        //     child: Text(
                        //       "Sign In",
                        //       style: TextStyle(
                        //         fontFamily: 'Rubik',
                        //         fontSize: 25,
                        //         fontWeight: FontWeight.w400,
                        //         // color: Colors.white,
                        //       ),
                        //     )),
                        // SizedBox(height: 20),



                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
