import 'package:fleet/data/model/company.dart';

abstract class DatabaseService{
  Future<void> addNewCompany({required Company company});
  Future<void> updateCompany({required Company company});
}