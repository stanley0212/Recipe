import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.api.dart';
import 'package:recipe/theme/theme_provide.dart';
import 'package:recipe/widget/recipe_card.dart';

import 'NavBar.dart';
import 'models/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: MyHomePage(),
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabcontroller;
  final List<Tab> topTabs = <Tab>[
    new Tab(text: "Beef"),
    new Tab(text: "Lamp"),
    new Tab(text: "Pork"),
    new Tab(text: "Chicken"),
    new Tab(text: "Sea food"),
  ];

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(vsync: this, length: 5);
    getRecipe();
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  late List<Recipe> _recipes;
  bool _isLoading = true;

  Future<void> getRecipe() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    //print(_recipes);
  }

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: false,
        title: Text('Recipe'),
        elevation: 4.0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: TabBar(
              isScrollable: true, // open scroll hoz
              controller: _tabcontroller,
              tabs: topTabs,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.maxFinite,
              height: 350.0,
              child: TabBarView(controller: _tabcontroller, children: [
                Container(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _recipes.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                  title: _recipes[index].name,
                                  cookTime: _recipes[index].totalTime,
                                  rating: _recipes[index].rating.toString(),
                                  thumbnaiUrl: _recipes[index].images);
                            },
                          )),
                Text('Lamp'),
                Text('Pork'),
                Text('Chicken'),
                Text('Sea food'),
              ]),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('aaa'),
                Text('bbb'),
                Text('ccc'),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('test'),
          ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => close(context, null),
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
