import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key, required this.onAddNewExpense});
  final void Function(Expense e) onAddNewExpense;
  @override
  State<StatefulWidget> createState() {
    return _AddNewExpense();
  }
}

class _AddNewExpense extends State<AddNewExpense> {
  //---------------------------------//
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.work;
  //---------------------------------//

  void _onSubmit() {
    final enteredAmount = double.tryParse(amountController.text);
    bool isAmountValid = enteredAmount == null || enteredAmount <= 0;
    //if data didn't full correctly....
    if (titleController.text.trim().isEmpty ||
        isAmountValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text("Please full the {Title, Amount and Date} correctly"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );

      //this return will enusre that if the conditions didn't met.
      //the other lines out of the if will not be exeuted.
      return;
    }
    // this will be executed when Submit button clicked, and
    // all feilds fulled correctly.
    widget.onAddNewExpense(
      Expense(
        title: titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );

    Navigator.pop(context);
  }

  void _openDatePicker() async {
    DateTime now = DateTime.now();
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Widget _amountTextField() {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        label: Text("Amount"),
      ),
    );
  }

  Widget _titleTextField() {
    return TextField(
      controller: titleController,
      maxLength: 50,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        label: Text("Tilte"),
      ),
    );
  }

  Widget _DatePickerButton() {
    return TextButton(
      onPressed: _openDatePicker,
      child: Icon(Icons.calendar_month_outlined),
    );
  }

  Widget _dropDownMenu() {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
        print(_selectedCategory);
      },
    );
  }

  @override
  Widget build(context) {
    final keyboardOverlappingSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, contstraint) {
        final isLandScape = contstraint.maxWidth >= 600;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  22, 16, 22, keyboardOverlappingSpace + 22),
              child: Column(
                children: [
                  if (isLandScape)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _titleTextField()),
                        SizedBox(width: 24),
                        Expanded(child: _amountTextField()),
                      ],
                    )
                  else
                    _titleTextField(),
                  Row(
                    children: [
                      if (isLandScape)
                        Expanded(
                          child: Row(
                            children: [
                              _dropDownMenu(),
                              Spacer(),
                              _DatePickerButton()
                            ],
                          ),
                        )
                      else
                        Expanded(child: _amountTextField()),
                      if (!isLandScape) _DatePickerButton(),
                      Text(_selectedDate == null
                          ? "Select Date"
                          : dateFormater.format(_selectedDate!)),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      if (!isLandScape) _dropDownMenu(),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          _onSubmit();
                        },
                        child: Text("Submit"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
