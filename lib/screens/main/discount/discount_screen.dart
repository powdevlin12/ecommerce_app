import 'dart:async';

import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/models/product/product.model.dart';
import 'package:ercomerce_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<ProductModel> _listProduct = [];
  Timer? _debounceTimer; // Timer để debounce
  final bool _isLoading = false;

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchResults(searchController.text);
    });
  }

  Future<void> _fetchSearchResults(String query) async {
    if (query.isEmpty) return;
    debugPrint(query);
    // Gọi API tìm kiếm (dưới đây là giả lập)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: kPaddingHorizontal, right: kPaddingHorizontal, top: 16.0),
          child: Expanded(
              child: Column(
            children: [
              SearchWidget(
                controller: searchController,
                onChanged: _onSearchChanged,
              )
            ],
          )),
        ),
      ),
    );
  }
}
