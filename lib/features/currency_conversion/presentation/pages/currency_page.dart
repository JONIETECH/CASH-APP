import 'package:finance_tracker/features/currency_conversion/presentation/widgets/currency_list.dart';
import 'package:finance_tracker/features/currency_conversion/presentation/widgets/currency_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/currency_conversion/presentation/bloc/currency_bloc.dart';

class CurrencyPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => CurrencyPage());

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {}); // triggers a rebuild to update the CurrencyList with the search term
  }

  void _onRefreshPressed() {
    context.read<CurrencyBloc>().add(FetchCurrencyRates('USD'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Rates'),
      ),
      body: Column(
        children: [
          CurrencySearchBar(controller: _searchController),
          Expanded(
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CurrencyLoaded) {
                  return CurrencyList(
                    rates: state.rates,
                    searchTerm: _searchController.text,
                  );
                } else if (state is CurrencyError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Please fetch currency rates.'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onRefreshPressed,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
