import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChatScreen.dart';
import 'Login_User/firebaseConn.dart';
import 'music.dart';
void main()  {
  //WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp();
  //   runApp(const App());
  // } catch (e) {
  //   print('Firebase initialization error: $e');
  // }
  runApp(MyApp());
}

final List<Pair> playlist = [
  Pair('assets/audio2.mp3', false),
  Pair('assets/audio1.mp3', false),
  Pair('assets/audio3.mp3', false)
];

class Pair {
  String str;
  bool vis;
  Pair(this.str, this.vis);
}


// class App extends StatefulWidget {
//   const App({super.key});
//   @override
//   State<App> createState() => _AppState();
// }
// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return   MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AudioPlayerScreen(),
//     );
//   }
// }
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
bool visiblePass=false;
final TextEditingController _email=TextEditingController();
final TextEditingController _pass=TextEditingController();
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double hi=MediaQuery.of(context).size.height;
    double wi=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: hi,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.greenAccent , Colors.blueGrey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),
             // color: Colors.grey,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: hi*0.06,),
                Container(
                  height: 120,
                  width: 200,
                  child: Image.asset('assets/dilkhushLogo.png'),
                ),
                Container(
                  height: 240,
                  width: 260,
                  decoration: const BoxDecoration(
                   // color: Colors.greenAccent,
                    image: DecorationImage(
                      image: AssetImage('assets/koyya.png'),
                      fit: BoxFit.fill
                    )
                  ),
                  //child: Image.asset('assets/logo-color.png', fit: BoxFit.fill,),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Color(0x10000000),
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width:wi*0.8 ,
                  child: TextFormField(
                    controller: _email,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.blueGrey,),
                      focusColor: Colors.black,
                      hintText: 'Phone number, email address, or username',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.white70),
                      // ),
                      contentPadding: EdgeInsets.only(top: 16),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Color(0x10000000),
                    color: Colors.white60,

                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width:wi*0.8 ,
                  child: TextFormField(
                    controller: _pass,
                    cursorColor: Colors.black,
                    obscuringCharacter: '*',
                    autocorrect: true,
                    obscureText: visiblePass,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(fontSize: 14),
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.password, color: Colors.blueGrey,),
                      focusColor: Colors.black,
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          visiblePass=!visiblePass;
                        });
                      }, icon: visiblePass ?Icon(Icons.visibility_off_outlined, color: Colors.black,):Icon(Icons.visibility_outlined, color: Colors.black,)),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      border: InputBorder.none,

                    ),

                  ),
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                  },
                  child: Container(
                    width: wi*0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.deepPurpleAccent,
                        thickness: 2,
                        height: 20,
                        indent: 20,
                        endIndent: 10,
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        color: Colors.deepPurpleAccent,
                        thickness: 2,
                        height: 20,
                        indent: 10,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.instagram, size: 40,color: Colors.deepOrange,),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return  AlertDialog(
                              title: const Text('Instagram Authentication'),
                              content:Container(
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                child: Text("Waiting for Instagram API"),
                              ),
                            );
                          },
                        );
                      },child: const Text('𝚕𝚘𝚐𝚒𝚗 𝚠𝚒𝚝𝚑 𝙸𝚗𝚜𝚝𝚊𝚐𝚛𝚊𝚖 ', style: TextStyle( fontSize: 16, color: Colors.black),),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.linkedin, size: 40,color: Colors.deepOrange,),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return  AlertDialog(
                              title: const Text('linkedin Authentication'),
                              content:Container(
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                child: Text("Waiting for linkedin API"),
                              ),
                            );
                          },
                        );
                      },child: const Text('𝚕𝚘𝚐𝚒𝚗 𝚠𝚒𝚝𝚑 𝙻𝚒𝚗𝚔𝚎𝚍𝙸𝚗', style: TextStyle( fontSize: 16, color: Colors.black),),),
                  ],
                ),
                TextButton(onPressed: (){}, child: Text("Forget password?", style: TextStyle(color: Colors.yellowAccent))),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.white,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('𝘿𝙤𝙣`𝙩 𝙝𝙖𝙫𝙚 𝙖𝙣 𝙖𝙘𝙘𝙤𝙪𝙣𝙩?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                  }, child: Text('Sign up.'))
                ],
                  ),
                ),
                SizedBox(height: 40,)

              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// class Register extends StatefulWidget {
//   const Register({super.key});
//   @override
//   State<Register> createState() => _RegisterState();
// }
// class _RegisterState extends State<Register> {
//   @override
//   Widget build(BuildContext context) {
//     double hi=MediaQuery.of(context).size.height;
//     double wi=MediaQuery.of(context).size.width;
//     return  Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           Container(
//             height: hi,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.green,Colors.cyan, Colors.black],
//                   begin: Alignment.bottomLeft,
//                   end: Alignment.topRight
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20,),
//                 Container(
//                   height: 100,
//                   width: 220,
//                   child: Image.asset('assets/social-pro.png', fit: BoxFit.fill,),
//                 ),
//                 SizedBox(height: 10,),
//
//                 Text('𝚂𝚒𝚐𝚗 𝚞𝚙 𝚝𝚘 𝚜𝚎𝚎 𝚙𝚑𝚘𝚝𝚘 𝚊𝚗𝚍 𝚟𝚒𝚍𝚎𝚘𝚜', style: TextStyle(fontSize: 16, color: Colors.white),),
//                 Text('𝚏𝚛𝚘𝚖 𝚢𝚘𝚞𝚛  𝚏𝚛𝚒𝚎𝚗𝚍𝚜', style: TextStyle(fontSize: 16, color: Colors.white),),
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return  AlertDialog(
//                           title: const Text('Facebook Authentication'),
//                           content:Container(
//                             height: 40,
//                             width: 80,
//                             alignment: Alignment.center,
//                             child: Text("Waiting for Facebook API"),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: wi*0.8,
//                     height: 45,
//                     decoration: BoxDecoration(
//                       color: Colors.blue[800],
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: const Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FaIcon(FontAwesomeIcons.facebook, size: 30,color: Colors.white,),
//                           SizedBox(width: 10,),
//                           Text(
//                             '𝙇𝙤𝙜 𝙞𝙣 𝙬𝙞𝙩𝙝 𝙁𝙖𝙘𝙚𝙗𝙤𝙤𝙠',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: Colors.white,
//                         thickness: 2,
//                         height: 20,
//                         indent: 20,
//                         endIndent: 10,
//                       ),
//                     ),
//                     Text("OR"),
//                     Expanded(
//                       child: Divider(
//                         color: Colors.white,
//                         thickness: 2,
//                         height: 20,
//                         indent: 10,
//                         endIndent: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//                       color: Colors.deepOrange
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20,),
//                         Text('Registration Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             // color: Color(0x10000000),
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 50,
//                           width:wi*0.8 ,
//                           child: TextFormField(
//                             style: TextStyle(fontSize: 14),
//                             textAlign: TextAlign.start,
//                             decoration: InputDecoration(
//                               hintText: 'Mobile Number or Email Address',
//                               border: InputBorder.none,
//                               // focusedBorder: OutlineInputBorder(
//                               //   borderSide: BorderSide(color: Colors.white70),
//                               // ),
//                               contentPadding: EdgeInsets.only(left: 10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 8,),
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             // color: Color(0x10000000),
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 50,
//                           width:wi*0.8 ,
//                           child: TextFormField(
//                             style: TextStyle(fontSize: 14),
//                             textAlign: TextAlign.start,
//                             decoration: InputDecoration(
//                               hintText: 'Full Name',
//                               border: InputBorder.none,
//                               // focusedBorder: OutlineInputBorder(
//                               //   borderSide: BorderSide(color: Colors.white70),
//                               // ),
//                               contentPadding: EdgeInsets.only(left: 10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 8,),
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             // color: Color(0x10000000),
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 50,
//                           width:wi*0.8 ,
//                           child: TextFormField(
//                             style: TextStyle(fontSize: 14),
//                             textAlign: TextAlign.start,
//                             decoration: const InputDecoration(
//                               hintText: 'Username',
//                               border: InputBorder.none,
//                               // focusedBorder: OutlineInputBorder(
//                               //   borderSide: BorderSide(color: Colors.white70),
//                               // ),
//                               contentPadding: EdgeInsets.only(left: 10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 8,),
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             // color: Color(0x10000000),
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 50,
//                           width:wi*0.8 ,
//                           child: TextFormField(
//                             style: TextStyle(fontSize: 14),
//                             textAlign: TextAlign.start,
//                             decoration: InputDecoration(
//                               hintText: 'Password',
//                               border: InputBorder.none,
//                               // focusedBorder: OutlineInputBorder(
//                               //   borderSide: BorderSide(color: Colors.white70),
//                               // ),
//                               contentPadding: EdgeInsets.only(left: 10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('𝘉𝘺 𝘴𝘪𝘨𝘯𝘪𝘯𝘨 𝘶𝘱, 𝘺𝘰𝘶 𝘢𝘨𝘳𝘦𝘦 𝘵𝘰 𝘰𝘶𝘳'),
//                             SizedBox(width: 5,),
//                             Container(height: 20,child: Text('𝐓𝐞𝐫𝐦 , 𝐏𝐫𝐢𝐯𝐚𝐜𝐲,', style: TextStyle(decoration: TextDecoration.underline)),)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("and"),
//                             SizedBox(width: 5,),
//                             Text("𝐂𝐨𝐨𝐤𝐢𝐞𝐬", style: TextStyle(decoration: TextDecoration.underline),),
//                           ],
//                         ),
//                         SizedBox(height: 20,),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: wi*0.8,
//                             height: 45,
//                             decoration: BoxDecoration(
//                               color: Colors.blue[600],
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '𝗦𝗶𝗴𝗻 𝗨𝗽',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         Container(
//                           margin: EdgeInsets.only(left: 20, right: 20),
//                           color: Colors.white,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('𝙃𝙖𝙫𝙚 𝙖𝙣 𝘼𝙘𝙘𝙤𝙪𝙣𝙩 ?'),
//                               TextButton(onPressed: (){
//                                 Navigator.pop(context);
//                               }, child: Text('𝙎𝙞𝙜𝙣 𝙞𝙣.', style: TextStyle(fontSize: 16),))
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 40,)
//                       ],
//                     ),
//                   ),
//                 ),
//
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isExpanded = false;
  final TextEditingController _name=TextEditingController();
  //final TextEditingController _mobile=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _userName=TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isExpanded = true;
      });
    });
  }

  Future<void> userLogin(String email, String pass, String username)async{
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      String userId=userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'username': username,
        // Add more user data as needed
      });
      print('User registered successfully!');
    }
    catch(err){
      print('Registration failed: $err');
    }

  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: hi,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green,Colors.cyan, Colors.black],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 100,
                  width: 220,
                  child: Image.asset('assets/social-pro.png', fit: BoxFit.fill,),
                ),
                SizedBox(height: 10,),
                //
                Text('𝚂𝚒𝚐𝚗 𝚞𝚙 𝚝𝚘 Listen audio', style: TextStyle(fontSize: 16, color: Colors.white),),
                // Text('𝚏𝚛𝚘𝚖 𝚢𝚘𝚞𝚛  𝚏𝚛𝚒𝚎𝚗𝚍𝚜', style: TextStyle(fontSize: 16, color: Colors.white),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return  AlertDialog(
                          title: const Text('Facebook Authentication'),
                          content:Container(
                            height: 40,
                            width: 80,
                            alignment: Alignment.center,
                            child: Text("Waiting for Facebook API"),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: wi*0.8,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.facebook, size: 30,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text(
                            '𝙇𝙤𝙜 𝙞𝙣 𝙬𝙞𝙩𝙝 𝙁𝙖𝙘𝙚𝙗𝙤𝙤𝙠',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                        height: 20,
                        indent: 20,
                        endIndent: 10,
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                        height: 20,
                        indent: 10,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Image.asset('assets/creditial.png', fit: BoxFit.fill,),
                ),

              ],
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOutSine,
            bottom: _isExpanded ? 0 : -hi * 0.64,
            left: 0,
            right: 0,
            height: hi * 0.55,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Colors.deepOrange
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Registration Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0x10000000),
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width:wi*0.8 ,
                    child: TextFormField(
                      controller: _email,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Mobile Number or Email Address',
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white70),
                        // ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0x10000000),
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width:wi*0.8 ,
                    child: TextFormField(
                      controller: _name,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white70),
                        // ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0x10000000),
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width:wi*0.8 ,
                    child: TextFormField(
                      controller: _userName,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white70),
                        // ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0x10000000),
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width:wi*0.8 ,
                    child: TextFormField(
                      controller: _pass,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white70),
                        // ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('𝘉𝘺 𝘴𝘪𝘨𝘯𝘪𝘯𝘨 𝘶𝘱, 𝘺𝘰𝘶 𝘢𝘨𝘳𝘦𝘦 𝘵𝘰 𝘰𝘶𝘳'),
                      SizedBox(width: 5,),
                      Container(height: 20,child: Text('𝐓𝐞𝐫𝐦 , 𝐏𝐫𝐢𝐯𝐚𝐜𝐲,', style: TextStyle(decoration: TextDecoration.underline)),)
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("and"),
                      SizedBox(width: 5,),
                      Text("𝐂𝐨𝐨𝐤𝐢𝐞𝐬", style: TextStyle(decoration: TextDecoration.underline),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: wi*0.8,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          '𝗦𝗶𝗴𝗻 𝗨𝗽',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('𝙃𝙖𝙫𝙚 𝙖𝙣 𝘼𝙘𝙘𝙤𝙪𝙣𝙩 ?'),
                        TextButton(onPressed: (){
                          if(_email.text!=null && _pass.text.length>=6 ){
                            userLogin(_email.text.trim(),_pass.text.trim(), _userName.text.trim());
                          }
                          Navigator.pop(context);
                        }, child: Text('𝙎𝙞𝙜𝙣 𝙞𝙣.', style: TextStyle(fontSize: 16),))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


