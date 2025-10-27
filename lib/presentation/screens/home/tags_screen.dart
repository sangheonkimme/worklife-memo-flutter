import 'package:flutter/material.dart';
import '../../widgets/common/app_empty_widget.dart';

/// Tags Screen
/// 태그 관리 화면
class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('태그'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 태그 검색
            },
            tooltip: '검색',
          ),
        ],
      ),
      body: AppEmptyWidget.noTags(
        onCreateTag: () {
          // TODO: 태그 생성 다이얼로그
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 태그 생성
        },
        tooltip: '태그 만들기',
        child: const Icon(Icons.add),
      ),
    );
  }
}
