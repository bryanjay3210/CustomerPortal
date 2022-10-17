import 'package:cp/enum.dart';
import 'package:cp/model/product/customer_product.dart';
import 'package:cp/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/product_repository.dart';

class ProductProvider {
  final productListState = BehaviorSubject<DataState>.seeded(DataState.initial);
  var products = <Product>[];
  var customerProduct = <CustomerProduct>[];

  Future<List<Product>> getProduct(
      Map<String, dynamic> map, BuildContext context) async {
    products = [];
    final productList = <Product>[];
    productListState.add(DataState.loading);
    Map<String, dynamic> data =
        await ProductRepository(map['server']).getProduct(map);
    if (data['Status'] == 'Success') {
      try {
        var prod = data['Plan'] as Map<String, dynamic>;
        productList.add(Product.fromJson(prod));
        productListState.add(DataState.success);
      } catch (e) {
        data['Plan'].forEach((element) {
          productList.add(Product.fromJson(element));
          productListState.add(DataState.success);
        });
      } finally {
        productListState.add(DataState.success);
      }
    }
    productList.sort(
      (a, b) => b.PlanID.compareTo(a.PlanID),
    );
    products.addAll(productList);
    return productList;
  }

  Future<List<CustomerProduct>> getCustomerProduct(
      Map<String, dynamic> map, BuildContext context) async {
    customerProduct.clear();
    final customerProductList = <CustomerProduct>[];
    productListState.add(DataState.loading);
    Map<String, dynamic> data =
        await ProductRepository(map['server']).getCustomerProduct(map);
    if (data['Status'] == 'Success') {
      try {
        List<dynamic> productList =
            data['ProductList']['Product'] as List<dynamic>;
        for (var ds in productList) {
          customerProductList
              .add(CustomerProduct.fromJson(ds as Map<String, dynamic>));
        }
      } catch (e) {
        Map<String, dynamic> product =
            data['ProductList']['Product'] as Map<String, dynamic>;
        customerProductList.add(CustomerProduct.fromJson(product));
        productListState.add(DataState.success);
      } finally {
        productListState.add(DataState.success);
      }
    }
    customerProductList.sort(
      (a, b) => b.ProductID.compareTo(a.ProductID),
    );
    customerProduct.addAll(customerProductList);
    productListState.add(DataState.success);
    return customerProductList;
  }
}
