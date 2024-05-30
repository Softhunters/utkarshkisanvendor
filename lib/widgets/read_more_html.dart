


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ReadMoreHtml extends StatefulWidget {
  final String? data;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? readMoreStyle;
  final TextAlign? textAlign;

  const ReadMoreHtml({
    Key? key,
    this.data,
    this.maxLines = 5,
    this.textStyle,
    this.readMoreStyle, this.textAlign,
  }) : super(key: key);

  @override
  _ReadMoreHtmlState createState() => _ReadMoreHtmlState();
}

class _ReadMoreHtmlState extends State<ReadMoreHtml> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Html(
          data: widget.data ?? "",
          style: {
            "body": Style(
              color: widget.textStyle?.color,
              fontSize: FontSize(widget.textStyle?.fontSize ?? 12.0),
              textAlign:widget.textAlign ?? TextAlign.justify,
              lineHeight: const LineHeight(1.5),
              // overflow: _isExpanded ? null : TextOverflow.ellipsis,
              maxLines: _isExpanded ? null : widget.maxLines,
            ),
          },
        ),
        if (!_isExpanded && _isExpandable())
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = true;
              });
            },
            child: Text(
              'Read More',
              style: widget.readMoreStyle ?? const TextStyle(color: Colors.blue),
            ),
          ),
        if (_isExpanded) // Show "Read Less" button if content is expanded
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = false;
              });
            },
            child: Text(
              'Read Less',
              style: widget.readMoreStyle ?? TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }

  bool _isExpandable() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.data,
        style: TextStyle(
          fontSize: widget.textStyle?.fontSize ?? 12.0,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    return textPainter.didExceedMaxLines;
  }
}