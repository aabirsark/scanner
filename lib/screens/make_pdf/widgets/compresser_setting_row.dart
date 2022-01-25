import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.make_pdf.dart';

class CompresserSettingsRow extends StatefulWidget {
  const CompresserSettingsRow({Key? key}) : super(key: key);

  @override
  _CompresserSettingsRowState createState() => _CompresserSettingsRowState();
}

class _CompresserSettingsRowState extends State<CompresserSettingsRow> {
  get defaultAnimationTime => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      // color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values
            .map((e) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.read<MakePdfPageHandler>().setTitle(e.value);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    alignment: Alignment.center,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          context.watch<MakePdfPageHandler>().title != e.value
                              ? Colors.grey.shade200
                              : Colors.black,
                    ),
                    child: Text(
                      e.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: context.watch<MakePdfPageHandler>().title ==
                                  e.value
                              ? Colors.grey.shade200
                              : Colors.black),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class CompresserValue {
  final String value;
  final VoidCallback callback;

  CompresserValue({required this.value, required this.callback});
}

List<CompresserValue> values = [
  CompresserValue(value: "On", callback: () {}),
  CompresserValue(value: "Off", callback: () {}),
];
