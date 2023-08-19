import 'package:assignment_2/resources/color_manager.dart';
import 'package:assignment_2/view/home/home_screen.dart';
import 'package:assignment_2/widgets/primary_textfiled.dart';
import 'package:flutter/material.dart';

import '../../service/api_services.dart';

// ignore: must_be_immutable
class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> with SingleTickerProviderStateMixin {
  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _idCtrl.dispose();
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.whiteColor,
      padding: const EdgeInsets.fromLTRB(15, 45, 15, 15),
      child: Column(
        children: [
          PrimaryTextField(
            textEditingController: _idCtrl,
            labelText: "Id",
            hintText: "Product Id",
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: PrimaryTextField(
              maxLength: 10,
              textEditingController: _titleCtrl,
              labelText: "Title",
              hintText: "product Title",
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: PrimaryTextField(
              maxLength: 10,
              prefixText: "₹\t",
              textEditingController: _amountCtrl,
              labelText: "Amount",
              hintText: "Add Amount",
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: PrimaryTextField(
              maxLength: 10,
              textEditingController: _quantityController,
              labelText: "quantity",
              hintText: "Add quantity",
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: PrimaryTextField(
              maxLength: 10,
              textEditingController: _descriptionController,
              labelText: "Description",
              hintText: "Add description",
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorManager.blackColor.withOpacity(0.9), elevation: 2),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: ColorManager.whiteColor),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: ColorManager.whiteColor, elevation: 2),
                child: const Text(
                  "Add product",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void onPressed() async{
    if (_idCtrl.text.trim().isEmpty ||
        _titleCtrl.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _amountCtrl.text.trim().isEmpty ||
        _quantityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Plz Enter all filled"),
        ),
      );
    } else {
      await ApiServices().addProduct({
        "productId": _idCtrl.text,
        "title": _titleCtrl.text,
        "amount": _amountCtrl.text,
        "quantity": _quantityController.text,
        "description": _descriptionController.text
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added Sucessfully"),
        ),
      );
      Navigator.pop(context);
    }
  }
}
