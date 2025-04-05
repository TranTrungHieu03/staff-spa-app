import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/features/appointment/data/model/product_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_product.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_product_detail.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getListProduct(GetListProductParams params);

  Future<ProductModel> getProductDetail(GetProductDetailParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  NetworkApiService _apiService;

  ProductRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<ProductModel>> getListProduct(GetListProductParams params) {
    // TODO: implement getListProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductDetail(GetProductDetailParams params) {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }
}
