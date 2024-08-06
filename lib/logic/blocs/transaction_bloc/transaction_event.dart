sealed class TransactionEvents {}

final class GetTransactionEvent extends TransactionEvents {}

final class AddTransactionEvent extends TransactionEvents {
  final DateTime date;
  final num amount;
  final num type;
  final num categoryId;

  AddTransactionEvent({
    required this.date,
    required this.amount,
    required this.type,
    required this.categoryId,
  });
}

final class EditTransactionEvent extends TransactionEvents {
  final int id;
  final DateTime date;
  final num amount;
  final num type;
  final num categoryId;
  EditTransactionEvent({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.categoryId,
  });
}

final class DeleteTransactionEvent extends TransactionEvents {
  final int id;
  DeleteTransactionEvent({required this.id});
}
