import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet/bloc/company/company_event.dart';
import 'package:fleet/bloc/company/company_state.dart';
import 'package:fleet/data/api/database_service.dart';
import 'package:fleet/data/model/company.dart';
import 'package:fleet/data/validator/input_validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState>{
  final DatabaseService databaseService;

  final _nameController=BehaviorSubject<String>();
  final _descriptionController=BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get descriptionStream => _descriptionController.stream;

  Stream<bool> get validateStreams => Rx.combineLatest2(nameStream, descriptionStream, (a, b) => true);

  CompanyBloc({required this.databaseService}) : super (InitialCompanyState()) {
    on<UpdateCompanyName>((event, emit) {
      if(InputValidator.nameValidation(event.props[0].toString())) {
        _nameController.sink.add(event.props[0].toString());
      }else {
        _nameController.sink.addError('Name must be at least 3 characters long');
      }
    });
    on<UpdateCompanyDescription>((event, emit) {
      if (InputValidator.notNullValidation(event.props[0].toString())) {
        _descriptionController.sink.add(event.props[0].toString());
      } else {
        _descriptionController.sink.add('');
      }
    });
    on<SaveCompany>((event, emit) async {
      try{
        await databaseService.addNewCompany(company: Company(name: _nameController.value, description: _descriptionController.value, ownerId: FirebaseAuth.instance.currentUser!.uid));
      } catch (e){
        emit(ErrorCompanyState(error: 'Error while connecting to the database'));
      }
    });
  }

}