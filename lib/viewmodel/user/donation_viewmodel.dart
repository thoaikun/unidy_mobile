import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/models/transaction_model.dart';
import 'package:unidy_mobile/services/transaction_service.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationViewModel extends ChangeNotifier {
  final TransactionService _transactionService = GetIt.instance<TransactionService>();
  final List<String> _suggestionDonations = ['100000', '200000', '500000', '1000000'];
  String _selectedSuggestion = '';

  final TextEditingController _amountOfMoneyController = TextEditingController();
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(locale: 'vi', symbol: 'đ', turnOffGrouping: false, decimalDigits: 0);
  final BehaviorSubject<String> _amountOfMoneySubject = BehaviorSubject<String>();
  final BehaviorSubject<int> _campaignIdSubject = BehaviorSubject<int>();
  final BehaviorSubject<int> _organizationIdSubject = BehaviorSubject<int>();

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

    Stream<int> campaignIdStream = _campaignIdSubject.stream;
    Stream<int> organizationIdStream = _organizationIdSubject.stream;
    Stream<String> amountOfMoneyStream = _amountOfMoneySubject.stream;
    CombineLatestStream.combine3(
        amountOfMoneyStream.transform(ValidationTransformer()),
        organizationIdStream,
        campaignIdStream,
        (amountOfMoney, organizationId, campaignId) {
          return <String, int>{
            'amounts': int.parse(amountOfMoney),
            'organizationUserId': organizationId,
            'campaignId': campaignId
          };
        })
        .debounceTime(const Duration(milliseconds: 500))
        .listen((payload) {
          _transactionService.createMomoTransaction(payload)
            .then((MomoTransaction momoTransaction) {
              _launchMomo(momoTransaction.deeplink);
          })
            .catchError((error) => print(error));
        })
        .onError((error, stackTrace) => print(error));
  }

  void onSelectedSuggestion(String value) {
    _selectedSuggestion = value;
    _amountOfMoneyController.text = value;
    notifyListeners();
  }

  void onDonate(int campaignId, int organizationId) {
    Sink<String> amountOfMoneyStream = _amountOfMoneySubject.sink;
    Sink<int> campaignIdStream = _campaignIdSubject.sink;
    Sink<int> organizationIdStream = _organizationIdSubject.sink;

    amountOfMoneyStream.add(Formatter.deFormatCurrency(_amountOfMoneyController.text));
    campaignIdStream.add(campaignId);
    organizationIdStream.add(organizationId);
  }

  Future<void> _launchMomo(String? url) async {
    if (url == null) return;
    // Launch the Momo app with the url
    if (! await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}