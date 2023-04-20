import 'package:equatable/equatable.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object?> get props => [];
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherLoaded extends VoucherState {
  final Voucher voucher;

  const VoucherLoaded(this.voucher);

  @override
  List<Object?> get props => [voucher];
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class VoucherFileOpenState extends Equatable {
  const VoucherFileOpenState();

  @override
  List<Object?> get props => [];
}

class VoucherFileOpenInitial extends VoucherFileOpenState {}

class VoucherFileOpenError extends VoucherFileOpenState {
  final String title;
  final String message;

  const VoucherFileOpenError(this.title, this.message);

  @override
  List<Object?> get props => [title, message];
}

class VoucherFileLoading extends VoucherFileOpenState {}
