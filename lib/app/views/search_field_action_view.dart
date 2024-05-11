import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFieldActionView extends GetView {
  final List<String> validEmails;
  final String labelText;
  final Function(String) getInput;
  final Function(bool)? isSelected;
  final bool isAgentLoading;
  

  const SearchFieldActionView({
    super.key,
    this.isSelected,
    required this.validEmails,
    required this.labelText,
    required this.getInput,
    required this.isAgentLoading,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        suffixText: isAgentLoading? 'Fetching leads...': null,
        suffixStyle: const TextStyle(
          fontSize: 14
        ),
        labelText: labelText,
        
        labelStyle: TextStyle(color: colorScheme.onSurface), // Style for label text
        
                floatingLabelStyle: TextStyle(color: colorScheme.primary),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)), // Less emphasis when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0), // Highlight with primary color when focused
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2.0), // Error state
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2.5), // Focused error state
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            } else {
              return validEmails.where((String option) {
                return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            }
          },
          onSelected: (String selection) {
            getInput(selection); // Use the callback here
            isSelected?.call(true);
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: getInputDecoration(labelText),
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a value";
                } else if (!validEmails.contains(value)) {
                  return "This entry is not recognized";
                }
                return null;
              },
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  color: colorScheme.primary.withOpacity(0.1), // Adjust background color here
                  width: constraints.maxWidth, // Width of the LayoutBuilder's constraints
                  child: Scrollbar(
                    child: ListView.separated(
                      separatorBuilder:(context, index) => Divider(
                        thickness: 0,endIndent: 0,indent: 0,height: 0,
                        color: colorScheme.onBackground.withOpacity(0.4),),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            minVerticalPadding: 0,
                            title: Text(option, style: TextStyle(color: colorScheme.onSurface)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}