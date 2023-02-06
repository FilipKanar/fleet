import 'package:fleet/bloc/company/company_bloc.dart';
import 'package:fleet/bloc/company/company_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class AddCompany extends StatelessWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder2(streams: StreamTuple2(
        BlocProvider.of<CompanyBloc>(context).nameStream,
        BlocProvider.of<CompanyBloc>(context).descriptionStream,
    ), builder: (context, snapshots){
      return Column(
        children: [
          TextField(
            onChanged: (name) {
              BlocProvider.of<CompanyBloc>(context).add(UpdateCompanyName(name: name));
            },
            decoration: InputDecoration(labelText: 'Company name', errorText: snapshots.snapshot1.hasError? snapshots.snapshot1.error.toString() : null),
          ),
          TextField(
            onChanged: (description) {
              BlocProvider.of<CompanyBloc>(context).add(UpdateCompanyDescription(description: description));
            },
            decoration: InputDecoration(labelText: 'Company description', errorText: snapshots.snapshot2.hasError? snapshots.snapshot2.error.toString() : null),
          ),
          StreamBuilder(stream: BlocProvider.of<CompanyBloc>(context).validateStreams,builder: (context, snapshot) {
            return ElevatedButton(onPressed: (){
              if(snapshot.data.runtimeType == bool && snapshot.data == true){
                BlocProvider.of<CompanyBloc>(context).add(SaveCompany());
              } else {
                BlocProvider.of<CompanyBloc>(context).add(ErrorCompany(error: 'Form is not completed'));
              }
            }, child: Text('save company'));
          }),
        ],
      );
    });
  }
}
