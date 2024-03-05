import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/services/transaction_service.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class DonationViewModel extends ChangeNotifier {
  TransactionService _transactionService = GetIt.instance<TransactionService>();
  final List<String> _suggestionDonations = ['100000', '200000', '500000', '1000000'];
  String _selectedSuggestion = '';

  final TextEditingController _amountOfMoneyController = TextEditingController();
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(locale: 'vi', symbol: 'đ', turnOffGrouping: false, decimalDigits: 0);
  final BehaviorSubject<String> _amountOfMoneySubject = BehaviorSubject<String>();

  List<String> get suggestionDonations => _suggestionDonations.map((e) => _currencyFormatter.format(e)).toList();
  String get selectedSuggestion => _selectedSuggestion;
  TextEditingController get amountOfMoneyController => _amountOfMoneyController;
  CurrencyTextInputFormatter get currencyFormatter => _currencyFormatter;

  DonationViewModel() {
    _amountOfMoneyController.addListener(() {
      if (suggestionDonations.contains(_amountOfMoneyController.text)) {
        _selectedSuggestion = _currencyFormatter.format(_amountOfMoneyController.text);
        notifyListeners();
      }
      else {
        _selectedSuggestion = '';
        notifyListeners();
      }
    });

    Stream<String> amountOfMoneyStream = _amountOfMoneySubject.stream;
    amountOfMoneyStream.transform(ValidationTransformer())
      .listen((amountOfMoney) {
        _transactionService.createMomoTransaction(amountOfMoney, '1', '1')
          .then((value) => print(value))
          .catchError((error) => print(error));
      })
      .onError((error, stackTrace) => print(error));
  }

  void onSelectedSuggestion(String value) {
    _selectedSuggestion = value;
    _amountOfMoneyController.text = value;
    notifyListeners();
  }

  void onDonate() {
    Sink<String> amountOfMoneyStream = _amountOfMoneySubject.sink;
    amountOfMoneyStream.add(_amountOfMoneyController.text);
  }
}