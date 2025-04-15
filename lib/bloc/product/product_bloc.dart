import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/product/product_event.dart';
import 'package:hiveee/bloc/product/product_state.dart';
import 'package:hiveee/bloc/user/user_state.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await productRepository.addProduct(event.product);

      emit(ProductSuccess(event.product));
    } catch (e) {
      emit(ProductFailure("Failed to Add Product"));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await productRepository.updateProduct(event.updatedProduct);
      emit(ProductSuccess(event.updatedProduct));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      Product? deletedProduct = await productRepository.getProductById(
        event.productId,
      );
      await productRepository.deleteProduct(event.productId);

      if (deletedProduct != null) {
        emit(ProductSuccess(deletedProduct));
      } else {
        emit(ProductFailure("Product not found"));
      }
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
