import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> options;
  final String title;
  final Color colors;
  final TextEditingController controller;
  const CustomDropDown(
      {Key key, this.options, this.title, this.colors, this.controller})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        //width: size.width * 0.90,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: DropdownButton<String>(
          hint: Text(
            widget.controller.value == TextEditingValue.empty
                ? widget.title
                : widget.controller.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          style: Theme.of(context).primaryTextTheme.caption,
          underline: const SizedBox.shrink(),
          icon: Icon(Icons.arrow_drop_down, color: widget.colors),
          items: widget.options.map(
            (String value) {
              return DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // const Icon(
                    //   Icons.arrow_drop_down,
                    //   size: 25,
                    //   color: Colors.black,
                    // )
                  ],
                ),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value;
            });
          },
        ));
  }
}
