import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/product_entity.dart';
import '../../bloc/product_bloc.dart';
import '../../bloc/product_event.dart';
import '../../bloc/product_state.dart';
import '../../widgets/custom_buttom.dart';
import 'addCustoms.dart';

class ADDPage extends StatefulWidget {
  const ADDPage({super.key});

  @override
  State<ADDPage> createState() => _ADDPageState();
}

class _ADDPageState extends State<ADDPage> {
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  File? _image;
  String? priceError;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    typeController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  bool _validatePrice() {
    if (priceController.text.isEmpty || double.tryParse(priceController.text) == null) {
      setState(() {
        priceError = 'Please enter a valid number';
      });
      return false;
    }
    setState(() {
      priceError = null;
    });
    return true;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    final parsedPrice = double.tryParse(value);
    if (parsedPrice == null) {
      return 'Price is not valid';
    }
    if (parsedPrice <= 0) {
      return 'Price must be greater than 0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.indigoAccent.shade400,
          ),
        ),
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductCreatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product Created Successfully')),
            );
            Navigator.of(context).pushNamed('/');
          } else if (state is ProductCreatedErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLargeScreen = constraints.maxWidth > 600;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerWidget(
                        image: _image,
                        onImagePick: _pickImage,
                      ),
                      const SizedBox(height: 20),
                      if (isLargeScreen)
                        Row(
                          children: [
                            Expanded(
                              child: FormFieldWidget(
                                label: 'Name',
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a product name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: FormFieldWidget(
                                label: 'Category',
                                controller: typeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a category';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      else ...[
                        FormFieldWidget(
                          label: 'Name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a product name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        FormFieldWidget(
                          label: 'Category',
                          controller: typeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a category';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 10),
                      FormFieldWidget(
                        label: 'Price',
                        controller: priceController,
                        validator: _priceValidator,
                      ),
                      if (priceError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            priceError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 10),
                      FormFieldWidget(
                        label: 'Description',
                        controller: descriptionController,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return CustomButton(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            borderColor: Theme.of(context).primaryColor,
                            buttonWidth: double.maxFinite,
                            buttonHeight: 45,
                            child: state is ProductLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text(
                                    'ADD',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                            onPressed: () {
                              if (_formKey.currentState!.validate() && _validatePrice()) {
                                context.read<ProductBloc>().add(
                                      CreateProductEvent(
                                        product: Product(
                                          id: '',
                                          name: nameController.text,
                                          price: double.parse(priceController.text),
                                          description: descriptionController.text,
                                          imageUrl: _image?.path ?? '', // Handle null or empty string for imageUrl
                                        ),
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            const Color.fromRGBO(255, 19, 19, 0.79),
                        borderColor: const Color.fromRGBO(255, 19, 19, 0.79),
                        buttonWidth: double.maxFinite,
                        buttonHeight: 45,
                        child: const Text(
                          'DELETE',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
