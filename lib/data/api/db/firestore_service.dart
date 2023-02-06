
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleet/data/model/company.dart';

import '../database_service.dart';

class FirestoreDatabaseService extends DatabaseService{
  @override
  Future<void> addNewCompany({required Company company}) async {
    DocumentReference documentReference = await FirebaseFirestore.instance.collection('companies').add(company.toJson());
    updateCompany(company: company.copyWith(id: documentReference.id));
  }

  @override
  Future<void> updateCompany({required Company company}) {
    return FirebaseFirestore.instance.collection('companies').doc(company.id).update(company.toJson());
  }
}