import 'package:cp/enum.dart';
import 'package:cp/model/invoice/invoice.dart';
import 'package:cp/model/invoice/invoice_detail.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/invoice_repository.dart';

class InvoiceProvider {
  final invoiceListState = BehaviorSubject<DataState>.seeded(DataState.initial);
  final invoiceDetailListState =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  final customerState = BehaviorSubject<DataState>.seeded(DataState.initial);
  var invoices = <Invoices>[];
  var invoiceDetail = <InvoicesDetail>[];
  final isLoading = BehaviorSubject<bool>.seeded(false);
  int totalPage = 0;
  String customer = '';
  String addressNo = '';
  String streetName = '';
  String streetDirection = '';
  String streetSuffix = '';
  String addressSuffix = '';
  String city = '';
  String state = '';
  String zip = '';
  String locationID = '';
  String customerService = '';
  String addressNoService = '';
  String streetNameService = '';
  String streetDirectionService = '';
  String streetSuffixService = '';
  String addressSuffixService = '';
  String cityService = '';
  String stateService = '';
  String zipService = '';
  String locationIDService = '';
  double pastDueBalance = 0.00;
  double currentBalanceDue = 0.00;
  double invoiceSubTot = 0.00;
  double payment = 0.00;

  Future<List<InvoicesDetail>> getInvoiceDetail(
      Map<String, dynamic> map, BuildContext context) async {
    invoiceDetail = [];
    final invoiceDetailList = <InvoicesDetail>[];
    invoiceDetailListState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getInvoiceDetails(map);
    if (data['Status'] != 'Success') {
      invoiceDetailListState.add(DataState.initial);
      return invoiceDetail;
    }
    try {
      if(data['InvoiceDetail'] is List<dynamic>){
        data['InvoiceDetail'].forEach((element) {
          invoiceDetailList.add(InvoicesDetail.fromJson(element));
        });
      } else if(data['InvoiceDetail'] is Map){
        invoiceDetailList.add(InvoicesDetail.fromJson(data['InvoiceDetail']));
      } else {
        invoiceDetailListState.add(DataState.success);
      }
    } catch (e) {

    }
    invoiceDetail.addAll(invoiceDetailList);
    // invoices.sort((a, b) => b.InvoiceStatus.compareTo(a.InvoiceStatus));
    invoiceDetailListState.add(DataState.success);
    return invoiceDetailList;
  }

  Future<List<Invoices>> getInvoiceInfo(
      Map<String, dynamic> map, BuildContext context) async {
    final invoiceList = <Invoices>[];
    invoiceListState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getInvoiceInfo(map);
    if (data['Status'] != 'Success') {
      invoiceListState.add(DataState.initial);
      return invoiceList;
    }
    totalPage = int.parse(data['PageTotal']);
    try {
      data['Invoice'].forEach((element) {
        invoiceList.add(Invoices.fromJson(element));
      });
    } catch (e) {}
    invoices.addAll(invoiceList);
    invoices.sort((a, b) => b.InvoiceIssueDate.compareTo(a.InvoiceIssueDate));
    invoiceListState.add(DataState.success);
    invoiceList.toSet().toList();
    return invoiceList;
  }

  Future<List<Invoices>> getInvoiceInfoByPage(
      Map<String, dynamic> map, BuildContext context) async {
    isLoading.add(true);
    final invoiceList = <Invoices>[];
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getInvoiceInfo(map);
    if (data['Status'] != 'Success') {
      return invoiceList;
    }
    totalPage = int.parse(data['PageTotal']);
    try {
      data['Invoice'].forEach((element) {
        invoiceList.add(Invoices.fromJson(element));
      });
    } catch (e) {}
    ;

    invoices.addAll(invoiceList);
    isLoading.add(false);
    invoiceList.toSet().toList();
    return invoiceList;
  }

  Future<List<Invoices>> searchInvoice(
      Map<String, dynamic> map, BuildContext context) async {
    invoices.clear();
    final invoiceList = <Invoices>[];
    invoiceListState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getInvoiceInfo(map);
    if (data['Status'] != 'Success') {
      invoiceListState.add(DataState.initial);
      return invoiceList;
    }
    totalPage = int.parse(data['PageTotal']);
    try {
     if(data['Invoice'] is List<dynamic>){
       data['Invoice'].forEach((element) {
         invoiceList.add(Invoices.fromJson(element));
       });
     } else if(data['Invoice'] is Map){
        invoiceList.add(Invoices.fromJson(data['Invoice']));
     } else {
       invoiceListState.add(DataState.success);
     }
    } catch (e) {
      invoiceListState.add(DataState.success);
    }

    invoices.addAll(invoiceList);
    invoiceListState.add(DataState.success);
    invoiceList.toSet().toList();
    return invoiceList;
  }

  getBalance(Map<String, dynamic> map, BuildContext context) async {
    invoiceListState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getBalance(map);
    payment = double.parse(data['Payment']['LastPaymentAmount'].isEmpty ? '0' : data['Payment']['LastPaymentAmount']);
    pastDueBalance = double.parse(data['Balances']['PastDueBalance'].isEmpty ? '0' : data['Balances']['PastDueBalance']);
    currentBalanceDue = double.parse(data['Balances']['CurrentBalanceDue'].isEmpty ? '0' : data['Balances']['CurrentBalanceDue']);
    invoiceSubTot = double.parse(data['ReferenceInvoice'].isEmpty ? '0' : data['ReferenceInvoice']['InvoiceSubTot']);
    invoiceListState.add(DataState.success);
  }

  sendInvoiceToEmail(Map<String, dynamic> map, BuildContext context) async {
    invoiceListState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).sendInvoiceToEmail(map);
    if (data['Status'] == 'Success') {
      const snackBar = SnackBar(
        content: Text('Send email successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(
        content: Text('${data['Status']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    invoiceListState.add(DataState.success);
  }

  getCustomer(Map<String, dynamic> map, BuildContext context) async {
    customerState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).getCustomer(map);
    if (data['Status'] == 'Success') {
      customer = data['CustomerName'].toString();
      data['Location'].forEach((element) {
        if (element['LocationType'].toString() == 'Billing') {
          addressNo = element['LocationAddressNumber'].toString();
          streetName = element['LocationStreetName'];
          streetDirection =
              element['LocationStreetDirection'].isEmpty
                  ? ''
                  : element['LocationStreetDirection'].toString();
          streetSuffix = element['LocationStreetSuffix'].isEmpty ? '' : element['LocationStreetSuffix'];
          addressSuffix = element['LocationAddressSuffix'].isEmpty
              ? ''
              : element['LocationAddressSuffix'].toString();
          city = element['LocationCity'];
          state = element['LocationState'];
          zip = element['LocationZip'];
          locationID = element['LocationID'];
        } else if (element['LocationType'].toString() == 'Service') {
          addressNoService = element['LocationAddressNumber'].toString();
          streetNameService = element['LocationStreetName'];
          streetDirectionService =
              element['LocationStreetDirection'].isEmpty
                  ? ''
                  : element['LocationStreetDirection'].toString();
          streetSuffixService = element['LocationStreetSuffix'].isEmpty ? '' : element['LocationStreetSuffix'];
          addressSuffixService =
              element['LocationAddressSuffix'].isEmpty
                  ? ''
                  : element['LocationAddressSuffix'].toString();
          cityService = element['LocationCity'];
          stateService = element['LocationState'];
          zipService = element['LocationZip'];
          locationIDService = element['LocationID'];
        }
      });
    }
    customerState.add(DataState.success);
  }

  updateCustomerInfo(Map<String, dynamic> map, BuildContext context) async {
    customerState.add(DataState.loading);
    Map<String, dynamic> data =
        await InvoiceRepository(map['server']).updateCustomerInfo(map);
    if (data['Status'] == 'Success') {
      showToast('Update billing address successfully!');
    } else {
      showToast('${data['Status']}');
    }
    customerState.add(DataState.success);
  }
}
