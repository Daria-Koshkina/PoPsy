import 'package:flutter/material.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/testsModels/Category.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;
  List<Category> chosenCategories;
  final bool isEditing;

  CategoryWidget({this.category, this.isEditing, this.chosenCategories});

  CategoryWidgetState createState() => CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  MaterialColor backColor;
  bool flag;

  @override
  void initState() {
    backColor = ColorPallet.placeholderColor;
    flag = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              if (widget.isEditing == true) {
                if (flag == false) {
                  backColor = ColorPallet.mainColor;
                  widget.chosenCategories.add(widget.category);
                  flag = true;
                } else {
                  backColor = ColorPallet.placeholderColor;
                  widget.chosenCategories.remove(widget.category);
                  flag = false;
                }
              }
            });
          },
          child: Text(
            widget.category.title,
            style: TextStyles.lightSubHeaderTextStyle,
          ),
        )
    );
  }
}