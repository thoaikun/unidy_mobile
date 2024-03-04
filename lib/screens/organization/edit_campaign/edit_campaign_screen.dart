import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';
import 'package:unidy_mobile/viewmodel/edit_campaign_viewmodel.dart';
import 'package:unidy_mobile/widgets/button/upload_btn.dart';
import 'package:unidy_mobile/widgets/image/image_preview.dart';
import 'package:unidy_mobile/widgets/input/editable_chip_input.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class EditCampaignScreen extends StatefulWidget {
  const EditCampaignScreen({super.key});

  @override
  State<EditCampaignScreen> createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditCampaignViewModel(
        showSnackBar: (String content) => ScaffoldMessenger.of(context).showSnackBar(_buildSnakeBar(content)),
      ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final NavigatorState navigatorState = Navigator.of(context);
          final bool shouldPop = await _onWillPop();
          if (shouldPop == true) {
            navigatorState.pop();
          }
          else {
            return;
          }
        },
        child: Consumer<EditCampaignViewModel>(
          builder: (BuildContext context, EditCampaignViewModel editCampaignViewModel, Widget? child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Tạo chiến dịch mới',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () => editCampaignViewModel.handleConfirm(),
                    icon: const Icon(Icons.done),
                    label: const Text('Hoàn tất')
                  )
                ],
              ),
              body: Consumer<EditCampaignViewModel>(
                builder: (BuildContext context, EditCampaignViewModel editCampaignViewModel, Widget? child) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: editCampaignViewModel.isLoading,
                        child: const LinearProgressIndicator(),
                      ),
                      Container(
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
                      ),
                    ],
                  );
                }
              ),
            );
          }
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
      child: Consumer<EditCampaignViewModel>(
        builder: (BuildContext context, EditCampaignViewModel editCampaignViewModel, Widget? child) {
          return Padding(
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
                Input(
                  controller: editCampaignViewModel.titleController,
                  label: 'Tên chiến dịch',
                  error: editCampaignViewModel.titleError,
                  prefixIcon: const Icon(Icons.campaign_rounded),
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.descriptionController,
                  label: 'Mô tả',
                  error: editCampaignViewModel.descriptionError,
                  prefixIcon: const Icon(Icons.description_rounded),
                ).textarea(),
                const SizedBox(height: 10),
                EditableChipInput(
                  toppings: editCampaignViewModel.hagTags,
                  onChanged: editCampaignViewModel.handleAddHagTag,
                  onDeleted: editCampaignViewModel.handleRemoveHagTag,
                  onSubmitted: editCampaignViewModel.handleSubmitHagTag,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.openFormTimeController,
                  label: 'Thời gian mở đơn',
                  error: editCampaignViewModel.openFormTimeError,
                  prefixIcon: const Icon(Icons.calendar_month_rounded),
                  onTap: () => editCampaignViewModel.selectDate(context, 'openFormTime'),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.closeFormTimeController,
                  label: 'Thời gian đóng đơn',
                  error: editCampaignViewModel.closeFormTimeError,
                  prefixIcon: const Icon(Icons.calendar_month_rounded),
                  onTap: () => editCampaignViewModel.selectDate(context, 'closeFormTime'),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.budgetTargetController,
                  label: 'Mục tiêu (tùy chọn)',
                  prefixIcon: const Icon(Icons.attach_money_rounded),
                  numberKeyboard: true,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.targetVolunteerController,
                  label: 'Số lượng tình nguyện viên (tùy chọn)',
                  prefixIcon: const Icon(Icons.volunteer_activism_rounded),
                  numberKeyboard: true,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.startDateController,
                  label: 'Thời gian diễn ra',
                  error: editCampaignViewModel.startDateError,
                  prefixIcon: const Icon(Icons.access_time_rounded),
                  onTap: () => editCampaignViewModel.selectDate(context, 'startDate'),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editCampaignViewModel.locationController,
                  label: 'Địa điểm',
                  error: editCampaignViewModel.locationError,
                  prefixIcon: const Icon(Icons.location_on_rounded),
                ),
                const SizedBox(height: 25),
                Text('Danh mục', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: VolunteerCategory.categories.map((category) {
                    return FilterChip(
                      label: Text(category.toString()),
                      onSelected: (bool selected) {
                        editCampaignViewModel.toggleCategory(selected, category);
                      },
                      selected: editCampaignViewModel.selectedCategories.contains(category),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
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
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    )) ?? false;
  }

  SnackBar _buildSnakeBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }
}
