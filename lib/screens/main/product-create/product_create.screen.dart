import 'dart:io';

import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/configs/size.dart';
import 'package:ercomerce_app/widgets/app_bar_widget.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/widgets/dropdown_button_form_widget.dart';
import 'package:ercomerce_app/widgets/text_field_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productDescription = TextEditingController();
  final _productName = TextEditingController();
  final _productPrice = TextEditingController();
  final _productQuantity = TextEditingController();
  final _productManuifacturer = TextEditingController();
  final _productColor = TextEditingController();
  final _productModelType = TextEditingController();

  final List<String> _productType = ['Electronics', 'Clothes'];
  String _selectedProductType = 'Electronics';

  void _onPressBack() {
    Navigator.pop(context);
  }

  // ** handle select image
  File? _imageFile;

  bool _isLoading = false;

  // Hàm kiểm tra và yêu cầu quyền
  Future<void> _checkPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bạn cần cấp quyền để tiếp tục")),
      );
    }
  }

  // Chọn ảnh từ Camera
  Future<void> _pickImageFromCamera() async {
    await _checkPermission(Permission.camera);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Chọn ảnh từ Gallery
  Future<void> _pickImageFromGallery() async {
    await _checkPermission(Permission.photos);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

// ** end

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select image")),
        );
        return;
      }

      // Gửi yêu cầu tạo sản phẩm
      Api.requestCreateProduct(
              productName: _productName.text,
              productDescription: _productDescription.text,
              productPrice: int.parse(_productPrice.text),
              productQuantity: int.parse(_productQuantity.text),
              productManuifacturer: _productManuifacturer.text,
              productColor: _productColor.text,
              productModelType: _productModelType.text,
              productType: _selectedProductType,
              file: _imageFile!)
          .then((result) {
        setState(() {
          Navigator.pop(context);
          // Đặt trạng thái loading về false
          setState(() {
            _isLoading = false;
          });
        });

        if (result.statusCode == 200) {
          // Xử lý thành công, có thể điều hướng hoặc thông báo
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.message)),
          );
        }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred while creating the product')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: kPaddingHorizontal, right: kPaddingHorizontal),
          child: Column(
            children: [
              AppBarWidget(title: "Create Product", onPressBack: _onPressBack),
              const Gap(16),
              Expanded(
                  child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Name',
                        label: 'Product Name',
                        controller: _productName,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter product name'
                            : null,
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Description',
                        label: 'Product Description',
                        controller: _productDescription,
                        maxLines: 2,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter product description'
                            : null,
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Price',
                        label: 'Product Price',
                        controller: _productPrice,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter product price'
                            : null,
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Quantity',
                        label: 'Product Quantity',
                        controller: _productQuantity,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter product quantity'
                            : null,
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                      const Gap(16.0),
                      DropdownButtonFormWidget(
                        labelText: 'Product Type',
                        listOptions: _productType,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProductType = newValue!;
                          });
                        },
                        selectedValue: _selectedProductType,
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Manufacturer',
                        label: 'Product Manufacturer',
                        controller: _productManuifacturer,
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Color',
                        label: 'Product Color',
                        controller: _productColor,
                      ),
                      const Gap(16.0),
                      TextFieldWidget(
                        hintText: 'Product Model Type',
                        label: 'Product Model Type',
                        controller: _productModelType,
                      ),
                      const Gap(16),
                      const TextWidget(
                        content: "Product images",
                        size: 12.0,
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: Container(
                            width: 120.0,
                            height: 160.0,
                            decoration: BoxDecoration(
                                color: subBgColor,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: _imageFile == null
                                ? Icon(Icons.camera_alt,
                                    size: 32.0, color: primaryColor)
                                : Image.file(
                                    _imageFile!,
                                    height: 160,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      const Gap(16),
                      ButtonWidget(
                        text: 'Create',
                        onPressed: _onSubmit,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
