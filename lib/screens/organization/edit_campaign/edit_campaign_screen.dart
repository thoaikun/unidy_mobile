import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/edit_campaign_viewmodel.dart';
import 'package:unidy_mobile/widgets/image/image_preview.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/button/upload_btn.dart';

class EditCampaignScreen extends StatefulWidget {
  const EditCampaignScreen({super.key});

  @override
  State<EditCampaignScreen> createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditCampaignViewModel(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Tạo chiến dịch mới',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.done), label: const Text('Hoàn tất'))
            ],
          ),
          body: Consumer<EditCampaignViewModel>(
            builder: (BuildContext context, EditCampaignViewModel editCampaignViewModel, Widget? child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Tải hình ảnh',
                          style: Theme.of(context).textTheme.titleMedium
                        ),
                      ),
                    ),
                    _buildImageGrid(editCampaignViewModel),
                    _buildCampaignForm(),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  SliverGrid _buildImageGrid(EditCampaignViewModel editCampaignViewModel) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == editCampaignViewModel.files.length) {
            return UploadButton(
              onTap: () => editCampaignViewModel.handleAddImage(),
            );
          }
          else {
            return ImagePreview(
              file: editCampaignViewModel.files[index],
              onDelete: () =>  editCampaignViewModel.removeFile(editCampaignViewModel.files[index]),
            );
          }
        },
        childCount: editCampaignViewModel.files.length + 1
      ),
    );
  }

  SliverToBoxAdapter _buildCampaignForm() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin chung',
              style: Theme.of(context).textTheme.titleMedium
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Tên chiến dịch',
              prefixIcon: Icon(Icons.campaign_rounded),
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Mô tả',
              prefixIcon: Icon(Icons.description_rounded),
            ).textarea(),
            const SizedBox(height: 10),
            const Input(
              label: 'Thời gian mở đơn',
              prefixIcon: Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Thời gian đóng đơn',
              prefixIcon: Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Mục tiêu',
              prefixIcon: Icon(Icons.attach_money_rounded),
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Số lượng tình nguyện viên',
              prefixIcon: Icon(Icons.volunteer_activism_rounded),
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Thời gian diễn ra',
              prefixIcon: Icon(Icons.access_time_rounded),
            ),
            const SizedBox(height: 10),
            const Input(
              label: 'Thời gian diễn ra',
              prefixIcon: Icon(Icons.pin_drop_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thoát ra ?'),
        content: const Text('Nội dung của bài đăng sẽ không được lưu lại sau khi thoát'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/organization'),
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    )) ?? false;
  }
}
