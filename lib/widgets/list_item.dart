import 'package:flutter/material.dart';

import 'error.dart';
import 'loadmore_indicator.dart';

class ListItem<T> extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final int length;
  final List<T> items;
  final bool isLoading;
  final bool isFirstLoading;
  final bool error;
  final void Function() onRetry;
  final void Function() onLoadMore;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  ListItem({
    Key? key,
    required this.length,
    required this.items,
    required this.isLoading,
    required this.isFirstLoading,
    required this.error,
    required this.onRetry,
    required this.onLoadMore,
    required this.itemBuilder,
    required this.separatorBuilder
  }) : super(key: key) {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index < length) {
          return itemBuilder(context, index);
        }
        else if (index == length && isLoading) {
          return const LoadingMoreIndicator();
        }
        else if (index == length && error) {
          return ErrorPlaceholder(onRetry: onRetry);
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorBuilder(context, index);
      },
      itemCount: length + 1
    );
  }
}

class SliverListItem<T> extends StatelessWidget {
  final int length;
  final List<T> items;
  final bool isLoading;
  final bool isFirstLoading;
  final bool error;
  final void Function() onRetry;
  final void Function() onLoadMore;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  const SliverListItem({
    Key? key,
    required this.length,
    required this.items,
    required this.isLoading,
    required this.isFirstLoading,
    required this.error,
    required this.onRetry,
    required this.onLoadMore,
    required this.itemBuilder,
    required this.separatorBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index < length) {
            return itemBuilder(context, index);
          }
          else if (index == length && isLoading) {
            return const LoadingMoreIndicator();
          }
          else if (index == length && error) {
            return ErrorPlaceholder(onRetry: onRetry);
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return separatorBuilder(context, index);
        },
        itemCount: length + 1
    );
  }
}
