import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'countries.dart';
import 'phone_number.dart';

/// This widget is customized and reused from the intl_phone_number_input 0.6.0 for app specific purposes - https://pub.dev/packages/intl_phone_number_input

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;

  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;

  final List<String>? countries;

  final InputDecoration? decoration;

  final TextStyle? style;
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Placeholder Text to Display in Searchbar for searching countries
  final String searchText;

  /// Color of the country code
  final Color? countryCodeTextColor;

  /// Color of the drop down arrow
  final Color? dropDownArrowColor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  // TextInputAction? textInputAction;

  IntlPhoneField(
      {this.initialCountryCode,
      this.obscureText = false,
      this.textAlign = TextAlign.left,
      this.onTap,
      this.readOnly = false,
      this.initialValue,
      this.keyboardType = TextInputType.number,
      this.autoValidate = true,
      this.controller,
      this.focusNode,
      this.decoration,
      this.style,
      this.onSubmitted,
      this.validator,
      this.onChanged,
      this.countries,
      this.onCountryChanged,
      this.onSaved,
      this.showDropdownIcon = true,
      this.dropdownDecoration = const BoxDecoration(),
      this.inputFormatters,
      this.enabled = true,
      this.keyboardAppearance = Brightness.light,
      this.searchText = 'Search by Country Name',
      this.countryCodeTextColor,
      this.autofocus = false,
      this.dropDownArrowColor});

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  Map<String, String> _selectedCountry =
      countries.firstWhere((item) => item['code'] == 'US');
  List<Map<String, String>> filteredCountries = countries;
  FormFieldValidator<String>? validator;
  RegisterBloc _registerBloc = locator<RegisterBloc>();

  @override
  void initState() {
    super.initState();
    _registerBloc.initISO();
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries
          .firstWhere((item) => item['code'] == widget.initialCountryCode);
    }

    validator = widget.autoValidate
        ? ((value) => value != null ? 'Invalid Mobile Number' : null)
        : widget.validator;
  }

  @override
  void dispose() {
    _registerBloc.closeISO();
    super.dispose();
  }

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = countries
                          .where((country) => country['name']!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            filteredCountries[index]['flag']!,
                            style: TextStyle(fontSize: 30),
                          ),
                          title: Text(
                            filteredCountries[index]['name']!,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            filteredCountries[index]['dial_code']!,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            _selectedCountry = filteredCountries[index];
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      context: context,
      useRootNavigator: false,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFlagsButton(),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            child: TextFormField(
              initialValue: widget.initialValue,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText,
              textAlign: widget.textAlign,
              onTap: () {
                if (widget.onTap != null) widget.onTap!();
              },
              controller: widget.controller,
              focusNode: widget.focusNode,
              onFieldSubmitted: (s) {
                if (widget.onSubmitted != null) widget.onSubmitted!(s);
              },
              decoration: widget.decoration,
              style: widget.style,
              onSaved: (value) {
                if (widget.onSaved != null && value != null) {
                  _registerBloc.chnageCountryISOCode(_selectedCountry['code']!);
                  widget.onSaved!(
                    PhoneNumber(
                      countryISOCode: _selectedCountry['code']!,
                      countryCode: _selectedCountry['dial_code']!,
                      number: value,
                    ),
                  );
                }
              },
              onChanged: (value) {
                if (widget.onChanged != null) {
                  _registerBloc.chnageCountryISOCode(_selectedCountry['code']!);
                  widget.onChanged!(
                    PhoneNumber(
                      countryISOCode: _selectedCountry['code']!,
                      countryCode: _selectedCountry['dial_code']!,
                      number: value,
                    ),
                  );
                }
              },
              validator: validator,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              keyboardAppearance: widget.keyboardAppearance,
            ),
          ),
        ),
      ],
    );
  }

  DecoratedBox _buildFlagsButton() {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (widget.showDropdownIcon) ...[
                Icon(
                  Icons.arrow_drop_down,
                  color: widget.dropDownArrowColor,
                ),
                SizedBox(width: 4)
              ],
              Text(
                _selectedCountry['flag']!,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 8),
              FittedBox(
                child: Text(
                  _selectedCountry['dial_code']!,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: widget.countryCodeTextColor),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        onTap: _changeCountry,
      ),
    );
  }
}
