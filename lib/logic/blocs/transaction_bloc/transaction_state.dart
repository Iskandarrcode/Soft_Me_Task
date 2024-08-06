import 'package:soft_me/data/models/transaction_model.dart';

sealed class TransactionStates {}

final class InitialTransactionState extends TransactionStates {}

final class LoadingTransactionState extends TransactionStates {}

final class LoadedTransactionState extends TransactionStates {
  final List<TransactionModel> transactions;
  LoadedTransactionState({required this.transactions});
}

final class ErrorTransationState extends TransactionStates {
  final String message;
  ErrorTransationState({required this.message});
}
