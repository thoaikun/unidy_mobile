import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/add_post_viewmodel.dart';
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
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: CustomScrollView(
              slivers: [
                _buildTextAreaInput(addPostViewModel),
                _buildImageGrid(addPostViewModel),
                _buildButton(addPostViewModel)
              ],
            ),
          );
        }
    );
  }

  SliverList _buildTextAreaInput(AddPostViewModel addPostViewModel) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const Padding(
                padding: EdgeInsets.only(top: 20),
                child: AvatarCard(),
              );
            case 1:
              return const SizedBox(height: 5);
            case 2:
              return Input(
                controller: addPostViewModel.contentController,
                label: 'Nêu cảm nghĩ của bạn'
              ).textarea();
            case 3:
              return const SizedBox(height: 30);
            case 4:
              return Text(
                'Tải hình ảnh',
                style: Theme.of(context).textTheme.titleMedium,
              );
            case 5:
              return const SizedBox(height: 20);
          }
          return null;
        },
        childCount: 6, // Adjust the count according to your content
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
              child: FilledButton(onPressed: () {}, child: const Text('Đăng bài'))
            )
          ],
        ),
      ),
    );
  }

}
