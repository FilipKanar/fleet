
import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {}

class UpdateCompanyName extends CompanyEvent{
  final String name;
  UpdateCompanyName({required this.name});
  @override
  List<Object?> get props => [name];
}
class UpdateCompanyDescription extends CompanyEvent{
  final String description;
  UpdateCompanyDescription({required this.description});
  @override
  List<Object?> get props => [description];
}
class SaveCompany extends CompanyEvent{
  @override
  List<Object?> get props => [];
}
class ErrorCompany extends CompanyEvent{
  final String error;
  ErrorCompany({required this.error});
  @override
  List<Object?> get props => [error];
}