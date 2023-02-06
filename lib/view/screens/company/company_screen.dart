import 'package:fleet/bloc/company/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fleet/view/screens/company/add_company/add_company.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/db/firestore_service.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocProvider(create: (context) => CompanyBloc(databaseService: FirestoreDatabaseService()), child: AddCompany(),),
        ],
      ),
    );
  }
}

