import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/views_features/main_app_view.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/secondary_button_widget.dart';

// ignore: must_be_immutable
class LinkAdd extends StatefulWidget {
  static String id = '/linkadd';
  List? controller = ['ADD', 'UPDATE'];
  int? index = 0;
  int? idlink = 0;
  String? valueLink = '';
  String? valuetitle = '';
  // ignore: use_key_in_widget_constructors
  LinkAdd([this.index, this.idlink, this.valueLink, this.valuetitle]);

  @override
  State<LinkAdd> createState() => _LinkAddState();
}

class _LinkAddState extends State<LinkAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  updateUi() async {
    await getLinks(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    updateUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightPrimaryColor,
        title: Text(
          widget.index == 0 ? "ADD Link" : "UPDATE Link",
          style: const TextStyle(
              color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 100),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    initialValue: widget.index == 0 ? null : widget.valuetitle,
                    label: 'title',
                    hint: widget.index == 0 ? 'Snapchat' : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a title';
                      }
                      widget.valuetitle = value;
                      return null;
                    },
                    controller: widget.index == 0 ? titleController : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    label: 'link',
                    hint: widget.index == 0 ? 'example.com' : null,
                    initialValue: widget.index == 0 ? null : widget.valueLink,
                    controller: widget.index == 0 ? linkController : null,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Link';
                      }
                      if (!value.contains('https://')) {
                        return 'Link must start with https:';
                      }

                      widget.valueLink = value;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecondaryButtonWidget(
                      width: 120,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.index == 0) {
                            addLink(context, titleController.text,
                                linkController.text);
                            Navigator.of(context).pushNamed(MainAppView.id);
                          } else {
                            updateLink(context, widget.idlink!,
                                widget.valuetitle!, widget.valueLink!);
                            if (mounted) {
                              Navigator.pushNamed(context, MainAppView.id);
                            }
                          }
                        }
                      },
                      text: widget.index == 0 ? "ADD" : "UPDATE")
                ],
              )),
        ),
      ),
    );
  }
}
