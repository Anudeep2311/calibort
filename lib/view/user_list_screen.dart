import 'package:calibort_assignment/bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _hasMore) {
        context.read<UserBloc>().add(FetchUsers(_currentPage + 1));
      }
    });
    context.read<UserBloc>().add(FetchUsers(_currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading && _currentPage == 1) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          _currentPage++;
          _hasMore = state.users.length >= 6; // Assuming each page has 6 users

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar ?? ''),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    );
                  },
                ),
              ),
              if (state is UserLoading && _currentPage > 1)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _goToPreviousPage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue
                        // primary: Colors.blue,
                        ),
                    child: const Text('Previous Page'),
                  ),
                  ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue
                        // primary: Colors.blue,
                        ),
                    child: const Text('Next Page'),
                  ),
                ],
              ),
            ],
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No users found.'));
        }
      },
    );
  }

  void _goToNextPage() {
    if (_hasMore) {
      context.read<UserBloc>().add(FetchUsers(_currentPage + 1));
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      context.read<UserBloc>().add(FetchUsers(_currentPage - 1));
    }
  }
}
