import 'package:flutter/material.dart';
import 'alunos.dart';
import 'model.dart';
import 'edit.dart';
import 'add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(telaMain());
}

class telaMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alunos do IFMT",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Alunos do IF"),
        ),
        body: tela(),
      ),
    );
  }
}

class tela extends StatefulWidget {
  const tela({Key? key}) : super(key: key);

  @override
  _telaState createState() => _telaState();
}

class _telaState extends State<tela> {
  List<alunos> discentes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model().listarAlunos().then((value) {
      setState(() {
        discentes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(),),
        Expanded(
            flex: 21,
            child: ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: discentes.length,
            )),
        Expanded(
            flex: 2,
            child: ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black45),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => add(ultimo: discentes.length)
                  ));
                });
              },
              child: Icon(Icons.add),
            ))
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
        child: ListTile(
          title: Text(discentes[index].nome),
          tileColor: Colors.black12,
          subtitle: Column(children: [Container(child: Text(discentes[index].datNasc,), alignment: AlignmentDirectional.topStart),
           Container(child: Text(discentes[index].matricula), alignment: AlignmentDirectional.topStart)]),
          leading: GestureDetector(
            child: Wrap(
              children: [
                Container(child: ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            edit(al: discentes[index],)
                    )
                    );
                  }
                  );
                },
                child: Icon(Icons.edit),
                ),
                margin: const EdgeInsets.all(2.0),
              ),
              Container(child: ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    model().deletarAluno(discentes[index].id);
                    discentes.removeAt(index);
                  });
                },
                child: Icon(Icons.delete),
              ),
                margin: const EdgeInsets.all(2.0),

              ),
              ]
            ),
          ),

        ),
        margin: const EdgeInsets.all(2.0),
    );
  }
}
