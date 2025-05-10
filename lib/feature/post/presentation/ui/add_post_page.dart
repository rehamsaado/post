  import 'dart:io';
  import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
  import 'package:post/global_widget/App_text_button_widget.dart';
  import 'package:post/global_widget/app-text_field_widget.dart';
  import 'package:post/global_widget/app_avatar_widget.dart';
import 'package:post/global_widget/app_square_button.dart';
  import 'package:post/global_widget/app_text_widget.dart';

import '../../domain/entities/post.dart';

  class AddPostPage extends StatefulWidget {
    final Post? post;

     AddPostPage({super.key, this.post});

    @override
    State<AddPostPage> createState() => _AddPostPageState();
  }

  class _AddPostPageState extends State<AddPostPage> {
    File? _selectImage;
    final TextEditingController _textController = TextEditingController();

  _AddPostPageState();

    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectImage = File(pickedFile.path);
        });
      }
    }

    Future<void> _pickImageFromCamera() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _selectImage = File(pickedImage.path);
        });
      }
    }


    @override
    Widget build(BuildContext context) {
      final String userName = widget.post?.user.name ??"user name";
     // final String caption = widget.post?.caption ?? "";
      final String imageUrl = widget.post?.user.imageUrl ?? "assets/images/image_doctor.png";
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "create post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
        ),
        body:GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child:ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppAvatarWidget(

                      imageUrl:imageUrl ,
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppTextButtonWidget(
                                iconButton: Icons.public, label: "public "),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                  textController: _textController,
                  hint: "بم تفكر",
                ),
                if (_selectImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.file(_selectImage!, height: 200),
                  ),
                // const Spacer(),
                const SizedBox(height: 100),
                _buildOption(Icons.image, "photo/video", _pickImage,
                    iconColor: Colors.green),
                const SizedBox(height: 10),
                _buildOption(Icons.camera, "camera", _pickImageFromCamera,
                    iconColor: Colors.red),
                const SizedBox(
                  height: 10,
                ),



                const Center(child: AppSquareButton(text: "post"),),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildOption(
    IconData icon,
    String label,
    VoidCallback onTap, {
    Color iconColor = Colors.grey,
    double textSize = 15,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(fontSize: textSize),
          ),
        ],
      ),
    );
  }
