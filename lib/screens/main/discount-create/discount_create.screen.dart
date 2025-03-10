import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/utils/convert_color.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DiscountCreateScreen extends StatefulWidget {
  const DiscountCreateScreen({super.key});

  @override
  _DiscountCreateScreenState createState() => _DiscountCreateScreenState();
}

class _DiscountCreateScreenState extends State<DiscountCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();
  final _valueController = TextEditingController();
  final _maxUsesController = TextEditingController();
  final _maxUsesPerUserController = TextEditingController();
  final _minOverValueController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  String _selectedDiscountType = 'fixed_amount';
  String _selectedAppliesTo = 'all';
  bool _isActive = true;
  final List<String> _selectedProductIds = [];

  final List<String> _discountTypes = ['fixed_amount', 'percentage'];
  final List<String> _appliesToOptions = ['all', 'specific'];

  void _onPressBack() {
    Navigator.pop(context);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final discountData = {
        "discount_name": _nameController.text,
        "discount_description": _descriptionController.text,
        "discount_type": _selectedDiscountType,
        "discount_value": double.parse(_valueController.text),
        "discount_code": _codeController.text,
        "discount_start_date": _startDateController.text,
        "discount_end_date": _endDateController.text,
        "discount_max_uses": int.parse(_maxUsesController.text),
        "discount_uses_count": 0,
        "discount_max_uses_per_user": int.parse(_maxUsesPerUserController.text),
        "discount_min_over_value": double.parse(_minOverValueController.text),
        "discount_is_active": _isActive,
        "discount_applies_to": _selectedAppliesTo,
        "discount_product_ids": _selectedProductIds,
      };

      print(discountData); // For testing, replace with actual API call
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
              child: AppBarWidget(
                  title: "Create Discount", onPressBack: _onPressBack),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPaddingHorizontal),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        hintText: 'Discount Name',
                        label: 'Discount Name',
                        controller: _nameController,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter discount name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        controller: _descriptionController,
                        maxLines: 2,
                        hintText: 'Description',
                        label: 'Description',
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter description'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedDiscountType,
                        decoration: InputDecoration(
                          labelText: 'Discount Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: (primaryColor)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: hexToColor(inputBackgroundColor)),
                          ),
                          fillColor: hexToColor(inputBackgroundColor),
                          filled: true,
                        ),
                        items: _discountTypes.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDiscountType = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        hintText: 'Discount Value',
                        label: 'Discount Value',
                        controller: _valueController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter discount value'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        hintText: 'Discount Code',
                        label: 'Discount Code',
                        controller: _codeController,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter discount code'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: hexToColor(inputBackgroundColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: _startDateController,
                                decoration: const InputDecoration(
                                    hintText: 'Start Date',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 14.0)),
                                readOnly: true,
                                onTap: () =>
                                    _selectDate(context, _startDateController),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: hexToColor(inputBackgroundColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: _endDateController,
                                decoration: const InputDecoration(
                                    hintText: 'End Date',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 14.0)),
                                readOnly: true,
                                onTap: () =>
                                    _selectDate(context, _endDateController),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        hintText: 'Maximum Uses',
                        label: 'Maximum Uses',
                        
                        controller: _maxUsesController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter maximum uses'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        hintText: 'Maximum Uses Per User',
                        label: 'Maximum Uses Per User',
                        controller: _maxUsesPerUserController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter maximum uses per user'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        hintText: 'Minimum Order Value',
                        label: 'Minimum Order Value',
                        controller: _minOverValueController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter minimum order value'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedAppliesTo,
                        decoration: InputDecoration(
                          labelText: 'Applies To',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: (primaryColor)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: hexToColor(inputBackgroundColor)),
                          ),
                          fillColor: hexToColor(inputBackgroundColor),
                          filled: true,
                        ),
                        items: _appliesToOptions.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedAppliesTo = newValue!;
                          });
                        },
                      ),
                      Row(
                        children: [
                          const Text('Active Status:'),
                          const Gap(12.0),
                          Switch(
                            value: _isActive,
                            onChanged: (bool value) {
                              setState(() {
                                _isActive = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ButtonWidget(
                        text: 'Create Discount',
                        onPressed: _onSubmit,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
