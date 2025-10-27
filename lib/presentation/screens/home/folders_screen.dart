import 'package:flutter/material.dart';
import '../../widgets/common/app_empty_widget.dart';

/// Folders Screen
/// 폴더 관리 화면
class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('폴더'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 폴더 검색
            },
            tooltip: '검색',
          ),
        ],
      ),
      body: AppEmptyWidget.noFolders(
        onCreateFolder: () {
          // TODO: 폴더 생성 다이얼로그
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 폴더 생성
        },
        tooltip: '폴더 만들기',
        child: const Icon(Icons.create_new_folder),
      ),
    );
  }
}
