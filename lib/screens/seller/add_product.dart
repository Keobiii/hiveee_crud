import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hiveee/bloc/product/product_bloc.dart';
import 'package:hiveee/bloc/product/product_event.dart';
import 'package:hiveee/models/product.dart';
import 'package:hiveee/models/product_category.dart';
import 'package:hiveee/utils/Palette.dart';
import 'package:hiveee/widget/gradient_button.dart';
import 'package:hiveee/widget/login_field.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  // Dropdown items for user roles
  List<DropdownMenuItem<String>> get dropdownItems {
    return ProductCategory.values.map((category) {
      return DropdownMenuItem(
        child: Text(category.categoryName),
        value: category.categoryId.toString(),
      );
    }).toList();
  }

  String? selectedCategory = null;

  final _productFormKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productCategoryController = TextEditingController();
  final productImageController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _productFormKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Product',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 50),
                  LoginField(
                    hintText: 'Product Name',
                    controller: productNameController,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Description',
                    controller: productDescriptionController,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // LoginField(
                  //   hintText: 'Category',
                  //   controller: productCategoryController,
                  //   icon: Icons.email_outlined,
                  //   validator: (value) {
                  //     if (value == null || value.toString().isEmpty) {
                  //       return 'Please enter some text';
                  //     }

                  //     return null;
                  //   },
                  // ),
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Pallete.borderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),

                    validator:
                        (value) => value == null ? "Select a category" : null,
                    dropdownColor: Colors.black,
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                        print("Selected Role: ${selectedCategory}");
                      });
                    },
                    items: dropdownItems,
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Image',
                    controller: productImageController,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Price',
                    controller: productPriceController,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Quantity',
                    controller: productQuantityController,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Add Product',
                    onPressed: () {
                      if (_productFormKey.currentState!.validate()) {
                        final box = Hive.box<Product>('products');

                        final price_ = productPriceController.text;
                        var finalPrice;

                        final quantity_ = productQuantityController.text;
                        var finalQuan;

                        try {
                          finalPrice = double.parse(price_);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Price Error: " + e.toString()),
                            ),
                          );
                          return;
                        }

                        try {
                          finalQuan = int.parse(quantity_);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Quantity Error: " + e.toString()),
                            ),
                          );
                          return;
                        }

                        if (selectedCategory == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select a category")),
                          );
                          return;
                        }

                        int categoryId = int.parse(selectedCategory!);

                        final product = Product(
                          productId:
                              box.isEmpty ? 1 : box.values.last.productId + 1,
                          name: productNameController.text.trim(),
                          categoryId: categoryId,
                          description: productDescriptionController.text.trim(),
                          image: 'assets/images/shoe.png',
                          price: finalPrice,
                          quantity: finalQuan,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product Added successfully'),
                          ),
                        );

                        context.read<ProductBloc>().add(AddProduct(product));
                        Navigator.of(context).pop();
                      }

                      // Navigator.pushNamed(context, '/userPage');
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Cancel',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginScreen()),
                      // );

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
