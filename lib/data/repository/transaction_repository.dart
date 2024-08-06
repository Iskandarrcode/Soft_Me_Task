import 'package:soft_me/data/models/transaction_model.dart';
import 'package:soft_me/data/services/transaction_services.dart';

class TransactionRepository {
  final TransactionServices _dioTransactionServices;

  TransactionRepository({required TransactionServices dioTransactionServices})
      : _dioTransactionServices = dioTransactionServices;

  Future<List<TransactionModel>> getTransaction() async {
    return _dioTransactionServices.getTransaction();
  }

  Future addTransaction(
      DateTime date, num amount, num type, num categoryId) async {
    return _dioTransactionServices.addTransaction(
      date,
      amount,
      type,
      categoryId,
    );
  }

  Future editTransaction(
    int id,
    DateTime newDate,
    num newAmount,
    num newType,
    num newCategoryId,
  ) async {
    return _dioTransactionServices.editTransaction(
      id,
      newDate,
      newAmount,
      newType,
      newCategoryId,
    );
  }

  Future deleteTransaction(int id) async {
    return _dioTransactionServices.deleteTransaction(id);
  }
}
