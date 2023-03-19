// // ignore_for_file: unused_field

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ComplaintPopup extends StatefulWidget {
//   final String complaintID;
//   const ComplaintPopup({super.key, required this.complaintID});

//   @override
//   State<ComplaintPopup> createState() => _ComplaintPopupState();
// }

// class _ComplaintPopupState extends State<ComplaintPopup> {
//   final CollectionReference _complaintsCollectionReference =
//       FirebaseFirestore.instance.collection('complaints');
//   final DocumentReference _usersCollectionReference = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid);
//   bool bookmarked = false;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _usersCollectionReference.get().then((value) async {
//         // bookmarked =
//         // await value.data()!['bookmarks'].contains(widget.complaintId);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//         future: _usersCollectionReference.get(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshots) {
//           return StreamBuilder<DocumentSnapshot>(
//               stream: ComplaintShow(widget.complaintID).complaintsnap,
//               builder: (context, snapshot) {
//                 print(snapshot.data!.data());
//                 if (!snapshot.hasData) {
//                   return const Scaffold(
//                     body: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 } else {
//                   return Container();
//                   //   return Dialog(
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(10.0),
//                   //       ),
//                   //       elevation: 5.0,
//                   //       backgroundColor: Colors.transparent,
//                   //       child: Container(
//                   //           width: MediaQuery.of(context).size.width,
//                   //           color: Colors.white,
//                   //           padding: const EdgeInsets.all(15.0),
//                   //           child: SingleChildScrollView(
//                   //             child: Column(
//                   //               mainAxisSize: MainAxisSize.min,
//                   //               children: <Widget>[
//                   //                 Row(
//                   //                   children: <Widget>[
//                   //                     Expanded(
//                   //                       child: Column(
//                   //                         crossAxisAlignment:
//                   //                             CrossAxisAlignment.start,
//                   //                         children: <Widget>[
//                   //                           Container(
//                   //                             alignment: Alignment.topLeft,
//                   //                             child: Text(
//                   //                               snapshot.data!.data()!['title'],
//                   //                               textAlign: TextAlign.left,
//                   //                               style: const TextStyle(
//                   //                                   fontSize: 20.0,
//                   //                                   color: Color(0xFF181D3D),
//                   //                                   fontWeight: FontWeight.bold),
//                   //                             ),
//                   //                           ),
//                   //                           const SizedBox(
//                   //                             height: 6.0,
//                   //                           ),
//                   //                           const Text(
//                   //                             'posted by:',
//                   //                             style: TextStyle(fontSize: 12.0),
//                   //                           ),
//                   //                           Text(
//                   //                             snapshot.data.data()['email'],
//                   //                             style: const TextStyle(
//                   //                                 decoration:
//                   //                                     TextDecoration.underline,
//                   //                                 color: Color.fromRGBO(
//                   //                                     53, 99, 184, 1),
//                   //                                 fontStyle: FontStyle.italic,
//                   //                                 fontWeight: FontWeight.bold,
//                   //                                 fontSize: 12.0),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     //new Spacer(),
//                   //                     IconButton(
//                   //                       onPressed: () async {
//                   //                         if (await _userDocument.get().then(
//                   //                             (value) => value
//                   //                                 .data()['bookmarked']
//                   //                                 .contains(
//                   //                                     widget._complaintID))) {
//                   //                           await _userDocument.update({
//                   //                             'bookmarked':
//                   //                                 FieldValue.arrayRemove(
//                   //                                     [widget._complaintID])
//                   //                           });
//                   //                           setState(() {
//                   //                             bookmarked = false;
//                   //                           });
//                   //                         } else {
//                   //                           await _userDocument.update({
//                   //                             'bookmarked': FieldValue.arrayUnion(
//                   //                                 [widget._complaintID])
//                   //                           });
//                   //                           setState(() {
//                   //                             bookmarked = true;
//                   //                           });
//                   //                         }
//                   //                       },
//                   //                       icon: Icon(bookmarked
//                   //                           ? Icons.bookmark
//                   //                           : Icons.bookmark_border),
//                   //                     )
//                   //                   ],
//                   //                 ),
//                   //                 const SizedBox(
//                   //                   height: 10.0,
//                   //                 ),
//                   //                 Row(
//                   //                   children: <Widget>[
//                   //                     Text(
//                   //                       DateFormat('kk:mm:a').format(snapshot.data
//                   //                               .data()['filing time']
//                   //                               .toDate()) +
//                   //                           '\n' +
//                   //                           DateFormat('dd-MM-yyyy').format(
//                   //                               snapshot.data
//                   //                                   .data()['filing time']
//                   //                                   .toDate()),
//                   //                       style: const TextStyle(fontSize: 12.0),
//                   //                     ),
//                   //                     new Spacer(),
//                   //                     Text(snapshot.data.data()['category'],
//                   //                         style: const TextStyle(fontSize: 12.0))
//                   //                   ],
//                   //                 ),
//                   //                 const SizedBox(
//                   //                   height: 10.0,
//                   //                 ),
//                   //                 Text(snapshot.data.data()['description']),
//                   //                 const SizedBox(
//                   //                   height: 10.0,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   height: snapshot.data
//                   //                               .data()['list of Images']
//                   //                               .length !=
//                   //                           0
//                   //                       ? (3.8 *
//                   //                               MediaQuery.of(context)
//                   //                                   .size
//                   //                                   .height) /
//                   //                           10
//                   //                       : 0, // card height
//                   //                   child: PageView(
//                   //                       scrollDirection: Axis.horizontal,
//                   //                       controller:
//                   //                           PageController(viewportFraction: 1),
//                   //                       //pageSnapping: ,
//                   //                       children: snapshot.data
//                   //                           .data()['list of Images']
//                   //                           .map<Widget>((imag) => Card(
//                   //                                 elevation: 6.0,
//                   //                                 child: Image.network(
//                   //                                   imag,
//                   //                                 ),
//                   //                                 margin:
//                   //                                     const EdgeInsets.all(10.0),
//                   //                               ))
//                   //                           .toList()),
//                   //                 ),
//                   //                 const SizedBox(
//                   //                   height: 20.0,
//                   //                 ),
//                   //                 Row(
//                   //                   crossAxisAlignment: CrossAxisAlignment.end,
//                   //                   mainAxisAlignment: MainAxisAlignment.center,
//                   //                   children: <Widget>[
//                   //                     Container(
//                   //                       height: (0.8 *
//                   //                               MediaQuery.of(context)
//                   //                                   .size
//                   //                                   .height) /
//                   //                           10,
//                   //                       width: (1.05 *
//                   //                                   MediaQuery.of(context)
//                   //                                       .size
//                   //                                       .width -
//                   //                               30) /
//                   //                           3,
//                   //                       decoration: BoxDecoration(
//                   //                         color: const Color(0xFF181D3D),
//                   //                         shape: BoxShape.rectangle,
//                   //                         borderRadius: BorderRadius.only(
//                   //                             topLeft: Radius.circular((0.6 *
//                   //                                     MediaQuery.of(context)
//                   //                                         .size
//                   //                                         .height) /
//                   //                                 20),
//                   //                             bottomLeft: Radius.circular((0.6 *
//                   //                                     MediaQuery.of(context)
//                   //                                         .size
//                   //                                         .height) /
//                   //                                 20),
//                   //                             topRight: Radius.zero,
//                   //                             bottomRight: Radius.zero),
//                   //                       ),
//                   //                       child: Column(
//                   //                         mainAxisAlignment:
//                   //                             MainAxisAlignment.center,
//                   //                         children: <Widget>[
//                   //                           Text(
//                   //                             snapshot.data.data()['status'],
//                   //                             style: TextStyle(
//                   //                                 fontSize: (0.12 *
//                   //                                         MediaQuery.of(context)
//                   //                                             .size
//                   //                                             .width) /
//                   //                                     3,
//                   //                                 color: Colors.yellow[900],
//                   //                                 fontWeight: FontWeight.bold),
//                   //                           ),
//                   //                           Text(
//                   //                             'Status',
//                   //                             textAlign: TextAlign.center,
//                   //                             style: TextStyle(
//                   //                                 //fontWeight: FontWeight.bold,
//                   //                                 color: Colors.white,
//                   //                                 fontSize: (0.08 *
//                   //                                         MediaQuery.of(context)
//                   //                                             .size
//                   //                                             .width) /
//                   //                                     3),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     const VerticalDivider(
//                   //                       color: Color.fromRGBO(58, 128, 203, 1),
//                   //                       width: 1.0,
//                   //                     ),
//                   //                     /*InkWell(
//                   //                       onTap: () {},
//                   //                       child: Container(
//                   //                           width: (0.7 *
//                   //                                       MediaQuery.of(context)
//                   //                                           .size
//                   //                                           .width -
//                   //                                   30) /
//                   //                               3,
//                   //                           height: (0.8 *
//                   //                                   MediaQuery.of(context)
//                   //                                       .size
//                   //                                       .height) /
//                   //                               10,
//                   //                           decoration: BoxDecoration(
//                   //                             color: Color(0xFF181D3D),
//                   //                             shape: BoxShape.rectangle,
//                   //                           ),
//                   //                           child: Icon(
//                   //                             Icons.share,
//                   //                             size: (0.35 *
//                   //                                     MediaQuery.of(context)
//                   //                                         .size
//                   //                                         .height) /
//                   //                                 10,
//                   //                             color: Colors.white,
//                   //                           )),
//                   //                     ),
//                   //                     VerticalDivider(
//                   //                       color: Color.fromRGBO(58, 128, 203, 1),
//                   //                       width: 1.0,
//                   //                     ),*/
//                   //                     InkWell(
//                   //                       onTap: () {
//                   //                         setState(() {
//                   //                           /*if (_like == true) {
//                   //                     _like = false;
//                   //                     complaint.upvotes
//                   //                         .remove("MY EMAIL ID: FROM BACKEND");
//                   //                     //TODO: Upload complaint to Backend
//                   //                   } else {
//                   //                     _like = true;
//                   //                     complaint.upvotes.add("MY EMAIL ID: FROM BACKEND");
//                   //                     //TODO: Upload complaint to Backend
//                   //                   }*/
//                   //                         });
//                   //                       },
//                   //                       child: Container(
//                   //                         width: (1.05 *
//                   //                                     MediaQuery.of(context)
//                   //                                         .size
//                   //                                         .width -
//                   //                                 30) /
//                   //                             3,
//                   //                         height: (0.8 *
//                   //                                 MediaQuery.of(context)
//                   //                                     .size
//                   //                                     .height) /
//                   //                             10,
//                   //                         decoration: BoxDecoration(
//                   //                           color: const Color(0xFF181D3D),
//                   //                           shape: BoxShape.rectangle,
//                   //                           borderRadius: BorderRadius.only(
//                   //                               topLeft: Radius.zero,
//                   //                               bottomLeft: Radius.zero,
//                   //                               topRight: Radius.circular((0.6 *
//                   //                                       MediaQuery.of(context)
//                   //                                           .size
//                   //                                           .height) /
//                   //                                   20),
//                   //                               bottomRight: Radius.circular(
//                   //                                   (0.6 *
//                   //                                           MediaQuery.of(context)
//                   //                                               .size
//                   //                                               .height) /
//                   //                                       20)),
//                   //                         ),
//                   //                         child: Row(
//                   //                           mainAxisAlignment:
//                   //                               MainAxisAlignment.center,
//                   //                           children: <Widget>[
//                   //                             IconButton(
//                   //                               icon: const Icon(
//                   //                                   Icons.arrow_upward),
//                   //                               onPressed: () {
//                   //                                 if (snapshot.data
//                   //                                     .data()['upvotes']
//                   //                                     .contains(FirebaseAuth
//                   //                                         .instance
//                   //                                         .currentUser
//                   //                                         .uid)) {
//                   //                                   _complaints
//                   //                                       .doc(widget._complaintID)
//                   //                                       .update({
//                   //                                     'upvotes':
//                   //                                         FieldValue.arrayRemove([
//                   //                                       FirebaseAuth.instance
//                   //                                           .currentUser.uid
//                   //                                     ])
//                   //                                   });
//                   //                                 } else {
//                   //                                   _complaints
//                   //                                       .doc(widget._complaintID)
//                   //                                       .update({
//                   //                                     'upvotes':
//                   //                                         FieldValue.arrayUnion([
//                   //                                       FirebaseAuth.instance
//                   //                                           .currentUser.uid
//                   //                                     ])
//                   //                                   });
//                   //                                 }
//                   //                               },
//                   //                               color: snapshot.data
//                   //                                       .data()['upvotes']
//                   //                                       .contains(FirebaseAuth
//                   //                                           .instance
//                   //                                           .currentUser
//                   //                                           .uid)
//                   //                                   ? Colors.blue[400]
//                   //                                   : Colors.grey,
//                   //                               iconSize: (0.35 *
//                   //                                       MediaQuery.of(context)
//                   //                                           .size
//                   //                                           .height) /
//                   //                                   10,
//                   //                             ),
//                   //                             const SizedBox(
//                   //                               width: 4.0,
//                   //                             ),
//                   //                             Text(
//                   //                               snapshot.data
//                   //                                   .data()['upvotes']
//                   //                                   .length
//                   //                                   .toString(),
//                   //                               //complaint.upvotes.length.toString(),
//                   //                               style: const TextStyle(
//                   //                                   fontWeight: FontWeight.bold,
//                   //                                   color: Colors.white,
//                   //                                   fontSize: 15.0),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                       ),
//                   //                     )
//                   //                   ],
//                   //                 )
//                   //               ],
//                   //             ),
//                   //           )));
//                   // }
//                 }
//               });
//         });
//   }
// }

// class UpdateNotification {
//   final CollectionReference users =
//       FirebaseFirestore.instance.collection('users');
//   final CollectionReference complaints =
//       FirebaseFirestore.instance.collection('complaints');

//   Stream<DocumentSnapshot> get userssnap {
//     return users.doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
//   }
// }

// class ComplaintShow {
//   final CollectionReference complaints =
//       FirebaseFirestore.instance.collection('complaints');

//   String complaintID;

//   ComplaintShow(this.complaintID);

//   Stream<DocumentSnapshot> get complaintsnap {
//     return complaints.doc(complaintID).snapshots();
//   }
// }
