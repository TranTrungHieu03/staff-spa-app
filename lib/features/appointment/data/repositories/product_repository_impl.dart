import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/datasources/product_remote_data_source.dart';
import 'package:staff_app/features/appointment/data/model/product_model.dart';
import 'package:staff_app/features/appointment/domain/repository/product_repository.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_product.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_product_detail.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  ProductRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getListProduct(GetListProductParams params) {
    // TODO: implement getListProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductModel>> getProductDetail(GetProductDetailParams params) {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }
}
