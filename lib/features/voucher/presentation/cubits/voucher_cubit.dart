import 'package:bloc/bloc.dart';
import 'package:sme_plateia/features/voucher/domain/repositories/i_voucher_repository.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final IVoucherRepository _repository;

  VoucherCubit({required IVoucherRepository repository})
      : _repository = repository,
        super(VoucherInitial());

  Future<void> getVoucher(String id) async {
    emit(VoucherLoading());
    final result = await _repository.getVoucherById(id);
    result.fold(
      (failure) => emit(VoucherError('Erro ao buscar voucher')),
      (voucher) => emit(VoucherLoaded(voucher)),
    );
  }
}
