import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
CollectionReference driverCollection = FirebaseFirestore.instance.collection('Driver');
CollectionReference policeCollection = FirebaseFirestore.instance.collection('Police');

CollectionReference userLocCollection = FirebaseFirestore.instance.collection('UserLoc');
CollectionReference driverLocCollection = FirebaseFirestore.instance.collection('DriverLoc');
CollectionReference policeLocCollection = FirebaseFirestore.instance.collection('PoliceLoc');

CollectionReference dpahistory = FirebaseFirestore.instance.collection('DPaHistory');
CollectionReference pdrivahistory = FirebaseFirestore.instance.collection('PDrivHistory');