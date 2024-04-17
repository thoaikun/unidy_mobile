import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/post_emotional_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/viewmodel/user/home/add_post_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/user/home/profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/image/image_preview.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/button/upload_btn.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostViewModel>(
        builder: (BuildContext context, AddPostViewModel addPostViewModel, Widget? child) {
          return Stack(
            children: [
              Positioned(
                child: Visibility(
                  visible: addPostViewModel.isLoading,
                  child: const LinearProgressIndicator()
                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: CustomScrollView(
                  slivers: [
                    _buildTextAreaInput(addPostViewModel),
                    _buildImageGrid(addPostViewModel),
                    _buildButton(addPostViewModel)
                  ],
                ),
              ),
            ]
          );
        }
    );
  }

  SliverToBoxAdapter _buildTextAreaInput(AddPostViewModel addPostViewModel) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            controller: addPostViewModel.contentController,
            label: 'Nêu cảm nghĩ của bạn',
            error: addPostViewModel.contentError,
          ).textarea(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Thêm cảm xúc',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              addPostViewModel.postEmotionalData == null ? 
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8))
                      ),
                      builder: (BuildContext context) => _buildEmotionalSheetModal()
                    );
                  },
                  icon: const Icon(Icons.add_rounded)
                ) 
                :
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8))
                      ),
                      builder: (BuildContext context) => _buildEmotionalSheetModal()
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(addPostViewModel.postEmotionalData!.imgUrl, width: 20, height: 20),
                        const SizedBox(width: 5),
                        Text(addPostViewModel.postEmotionalData!.title)
                      ],
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Tải hình ảnh',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  SliverGrid _buildImageGrid(AddPostViewModel addPostViewModel) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == addPostViewModel.files.length) {
            return UploadButton(
              onTap: () => addPostViewModel.handleAddImage(),
            );
          }
          else {
            return ImagePreview(
              file: addPostViewModel.files[index],
              onDelete: () =>  addPostViewModel.removeFile(addPostViewModel.files[index]),
            );
          }
        },
        childCount: addPostViewModel.files.length + 1
      ),
    );
  }

  SliverToBoxAdapter _buildButton(AddPostViewModel addPostController) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(onPressed: addPostController.handleCancel, child: const Text('Hủy'))
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: FilledButton(
                onPressed: () {
                  addPostController.handleCreatePost()
                    .then((_) {
                      addPostController.cleanInput();
                      Provider.of<ProfileViewModel>(context, listen: false).cleanPostList();
                      ScaffoldMessenger.of(context).showSnackBar(_buildSnakeBar(true));
                    })
                    .catchError((error) {
                      if (error is ValidationException) {
                        return;
                      }
                      else if (error is ResponseException && error.code == ExceptionErrorCode.invalidToken) {
                        error.handleForbiddenException(
                          () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false
                          )
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            _buildSnakeBar(false));
                      }
                    })
                    .whenComplete(() => addPostController.setLoading(false));
                },
                child: const Text('Đăng bài'))
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionalSheetModal() {
    List<EPostEmotional> emotionalList = [
      EPostEmotional.admire,
      EPostEmotional.amazing,
      EPostEmotional.excited,
      EPostEmotional.happy,
      EPostEmotional.wonderful,
      EPostEmotional.relax
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.5,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          const Icon(
            Icons.remove,
            size: 40,
            color: TextColor.textColor200,
          ),
          Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: emotionalList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) => _buildEmotionalCard(emotionalList[index])
              )
          )
        ],
      ),
    );
  }

  Widget _buildEmotionalCard(EPostEmotional postEmotional) {
    return ListTile(
      leading: Image.asset(ePostEmotionalMap[postEmotional]!.imgUrl, width: 20, height: 20),
      title: Text(ePostEmotionalMap[postEmotional]!.title),
      onTap: () {
        Provider.of<AddPostViewModel>(context, listen: false).addEmotional(postEmotional);
        Navigator.pop(context);
      }
    );
  }

  SnackBar _buildSnakeBar(bool isUploadSuccess) {
    return SnackBar(
      content: isUploadSuccess ? const Text('Đăng bài thành công') : const Text('Có lỗi xảy ra, thử lại sau'),
      duration: const Duration(seconds: 2),
    );
  }
}
