import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_project/features/menu/data/menu_service.dart';
import 'package:games_project/features/menu/state/menu_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => MenuBloc(menuService: MenuService()),
        child: BlocListener<MenuBloc, MenuState>(
          listener: (context, state) {},
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 3,
                            mainAxisExtent: 300),
                    itemCount: state.game.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 233, 233, 233)),
                          child: Column(
                            children: [
                              Image.network(state.game[index].imagen!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/images/no-data.png'),
                                  height: 200),
                              Text(state.game[index].nombre ?? ''),
                              Text(state.game[index].fecha ?? ''),
                              Text(state.game[index].plataforma ?? '')
                            ],
                          ));
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }
}
