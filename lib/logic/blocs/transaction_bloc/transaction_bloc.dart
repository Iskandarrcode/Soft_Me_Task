import 'package:bloc/bloc.dart';
import 'package:soft_me/data/models/transaction_model.dart';
import 'package:soft_me/data/repository/transaction_repository.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_event.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvents, TransactionStates> {
  final TransactionRepository _transactionRepository;
  TransactionBloc({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(InitialTransactionState()) {
    on<GetTransactionEvent>(_getTransaction);
    on<AddTransactionEvent>(_addTransaction);
    on<EditTransactionEvent>(_editTransaction);
    on<DeleteTransactionEvent>(_deleteTransaction);
  }

  void _getTransaction(GetTransactionEvent event, Emitter emit) async {
    emit(LoadingTransactionState());
    try {
      final transactions = await _transactionRepository.getTransaction();
      emit(LoadedTransactionState(transactions: transactions));
    } catch (e) {
      emit(ErrorTransationState(message: e.toString()));
    }
  }

  void _addTransaction(AddTransactionEvent event, Emitter emit) async {
    List<TransactionModel> transactions = [];
    if (state is LoadedTransactionState) {
      transactions = (state as LoadedTransactionState).transactions;
    }

    emit(LoadingTransactionState());
    try {
      final transaction = await _transactionRepository.addTransaction(
        event.date,
        event.amount,
        event.type,
        event.categoryId,
      );

      print("Transection Add bloc: ${transaction["transaction"]}");
      transactions.add(
        TransactionModel.formJson(
          transaction["transaction"],
        ),
      );
      emit(LoadedTransactionState(transactions: transactions));
    } catch (e) {
      print("Transaction Qo'shish bloc : $e");
      emit(ErrorTransationState(message: e.toString()));
    }
  }

  void _editTransaction(EditTransactionEvent event, Emitter emit) async {
    try {
      await _transactionRepository.editTransaction(
        event.id,
        event.date,
        event.amount,
        event.type,
        event.categoryId,
      );
      add(GetTransactionEvent());
    } catch (e) {
      print("Category Edit qilishda Xatolik: $e");
      emit(ErrorTransationState(message: e.toString()));
    }
  }

  void _deleteTransaction(DeleteTransactionEvent event, Emitter emit) async {
    try {
      await _transactionRepository.deleteTransaction(event.id);
      add(GetTransactionEvent());
    } catch (e) {
      emit(ErrorTransationState(message: e.toString()));
    }
  }
}
