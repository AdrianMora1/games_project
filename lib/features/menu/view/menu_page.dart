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
    return BlocProvider(
      create: (_) => MenuBloc(menuService: MenuService()),
      child: BlocListener<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state.status == MenuStatus.addGameSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Juego añadido'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ));
          }
          if (state.status == MenuStatus.deleteGameSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Juego eliminado'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          builder: (mainContext, state) {
            return Scaffold(
              drawer: Container(
                width: 200,
                color: const Color.fromARGB(230, 255, 255, 255),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Filtrar por plataformas',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return TextButton.icon(
                                  style: const ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(0, 255, 255, 255)),
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(200, 60)),
                                      iconColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    mainContext.read<MenuBloc>().add(
                                        GetGamesCatalogEvent(
                                            category: state
                                                .categories[index].filterName));
                                  },
                                  icon: Icon(
                                    state.categories[index].icono,
                                  ),
                                  label: Text(
                                    state.categories[index].nombre,
                                    style: const TextStyle(color: Colors.black),
                                  ));
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: TextField(
                  onChanged: (value) {
                    mainContext
                        .read<MenuBloc>()
                        .add(GetGamesCatalogEvent(name: value));
                  },
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 216, 216, 216),
                    filled: true,
                    hintText: 'Buscar juegos',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: TextButton.icon(
                        style: ButtonStyle(
                            alignment: Alignment.center,
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.green),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(140, 50)),
                            iconColor:
                                const MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          showFormDialog(mainContext);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Añadir',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 3,
                            mainAxisExtent: 310),
                    itemCount: state.game.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 233, 233, 233)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      tooltip: 'Eliminar',
                                      onPressed: () {
                                        mainContext.read<MenuBloc>().add(
                                            DeleteGameEvent(
                                                gameId: state.game[index].id!));
                                      },
                                      icon: const Icon(Icons.delete_forever),
                                      color: Colors.red),
                                ],
                              ),
                              Image.network(state.game[index].imagen!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        'assets/images/no-data.png',
                                        height: 200,
                                      ),
                                  height: 200),
                              Text(state.game[index].nombre ?? ''),
                              Text(state.game[index].fecha ?? ''),
                              Text(state.game[index].plataforma ?? '')
                            ],
                          ));
                    },
                  )),
            );
          },
        ),
      ),
    );
  }

  void showFormDialog(BuildContext mainContext) {
    final formKey = GlobalKey<FormState>(); // Clave para el formulario
    String nombre = '';
    String categoria = '';
    DateTime fecha = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Añadir juego'),
          content: Form(
            key: formKey,
            child: SizedBox(
              width: 500,
              height: 530,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Introduzca el nombre',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduzca el nombre';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nombre = value ?? '';
                    },
                  ),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    onDateChanged: (value) => fecha = value,
                  ),
                  const Text('Plataforma:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Introduzca la plataforma',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduzca la plataforma';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      categoria = value ?? '';
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  alignment: Alignment.center,
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.green),
                  fixedSize: const MaterialStatePropertyAll(Size(140, 50)),
                  iconColor: const MaterialStatePropertyAll(Colors.white)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(mainContext).pop();
                  mainContext.read<MenuBloc>().add(AddGameEvent(
                      category: categoria, date: fecha, name: nombre));
                }
              },
              child: const Text(
                'Añadir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
