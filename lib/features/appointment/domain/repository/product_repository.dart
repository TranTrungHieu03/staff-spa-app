import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/model/product_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_product.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_product_detail.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getListProduct(GetListProductParams params);

  Future<Either<Failure, ProductModel>> getProductDetail(GetProductDetailParams params);
}
