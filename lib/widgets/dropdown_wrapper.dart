
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extenstion.dart';
import '../main.dart';

/// Flutter code sample for [DropdownButton].

class DropdownButtonExample extends StatefulWidget {
  final List<String> list;
  final String value;
  final void Function(String) onChangedCallback;

  const DropdownButtonExample({Key? key, required this.list, required this.onChangedCallback, required this.value})
      : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calculateSize(context, 250),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: calculateSize(context,16), vertical: calculateSize(context,12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
        ),
        value: dropdownValue ,
        //Provider.of<Bill>(context).users_list[ Provider.of<Bill>(context).choosenUser],
        icon: Icon(Icons.expand_circle_down_rounded, color: Theme.of(context).primaryColor),
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            widget.onChangedCallback(dropdownValue);
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            onTap: () {
              ;
              // Provider.of<Bill>(context, listen: false).chooseUser(value);
              // print(Provider.of<Bill>(context, listen: false).choosenUser);
            },
            enabled: true,
            value: value,
            child: Container(
              alignment: Alignment.center,
              child: AutoSizeText(maxLines: 1,
                value,                      //labelSmall (skiny) & opacity null
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor.withOpacity(0.6)),
              ),
            ),
          );
        }).toList(),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98),
      ),
    );
  }
}


