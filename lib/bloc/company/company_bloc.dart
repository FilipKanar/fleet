import 'package:fleet/bloc/company/company_event.dart';
import 'package:fleet/bloc/company/company_state.dart';
import 'package:fleet/data/validator/input_validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState>{

  final _nameController=BehaviorSubject<String>();
  final _descriptionController=BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get descriptionStream => _descriptionController.stream;

  Stream<bool> get validateStreams => Rx.combineLatest2(nameStream, descriptionStream, (a, b) => true);

  CompanyBloc() : super (InitialCompanyState()) {
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
    on<SaveCompany>((event, emit) {
      //TODO: Save company to database
    });
  }

}