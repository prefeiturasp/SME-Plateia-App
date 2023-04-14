import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';

import 'package:sme_plateia/app/network/network_info.dart';
import 'package:sme_plateia/features/voucher/data/datasources/voucher_remote_data_source.dart';

import 'package:sme_plateia/features/voucher/data/models/voucher.model.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher_file.model.dart';

import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';
import 'package:sme_plateia/features/voucher/domain/repositories/i_voucher_repository.dart';

@LazySingleton(as: IVoucherRepository)
class VoucherRepository implements IVoucherRepository {
  final IVoucherRemoteDataSource voucherRemoteDataSource;
  final INetworkInfo networkInfo;

  VoucherRepository(
    this.voucherRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Voucher>> getVoucherById(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await voucherRemoteDataSource.getVoucherById(id: id);

        final VoucherModel voucherModel = result;

        return Right(voucherModel.toDomain());
      } on Failure catch (e) {
        debugPrint(e.toString());
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(Failure.noConnectionFailure(message: 'Sem conexão com a internet'));
    }
  }

  @override
  Future<Either<Failure, VoucherFile>> getVoucherFileById(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await voucherRemoteDataSource.getVoucheFilerById(id: id);

        final VoucherFileModel voucherFileModel = result;

        return Right(voucherFileModel.toDomain());
      } on Failure catch (e) {
        debugPrint(e.toString());
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(Failure.noConnectionFailure(message: 'Sem conexão com a internet'));
    }
  }
}
