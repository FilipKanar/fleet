
import 'package:equatable/equatable.dart';

abstract class CompanyState extends Equatable{}

class InitialCompanyState extends CompanyState{
  @override
  List<Object?> get props => [];

}

class ErrorCompanyState extends CompanyState{
  final String error;
  ErrorCompanyState({required this.error});
  @override
  List<Object?> get props => [];
}
