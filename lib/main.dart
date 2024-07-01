import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/app.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/init_dependecies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      
      ),
       
    ],
    child: const MainApp(),
  ));
  
}

class MyApp extends StatelessWidget {
  // Dummy expense data
  final List<Map<String, dynamic>> expenseData = [
    {'category': 'Food', 'amount': 20.0, 'date': '2024-06-01'},
    {'category': 'Transport', 'amount': 15.0, 'date': '2024-06-02'},
    {'category': 'Entertainment', 'amount': 50.0, 'date': '2024-06-03'},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(expenseData: expenseData),
      routes: {
        '/reports': (context) => ReportsPage(expenseData: expenseData),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> expenseData;

  const HomeScreen({Key? key, required this.expenseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Tracker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/reports', arguments: expenseData);
          },
          child: Text('View Reports & Analytics'),
        ),
      ),
    );
  }
}