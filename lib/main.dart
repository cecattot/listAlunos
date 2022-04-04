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
        Expanded(
            flex: 7,
            child: ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: discentes.length,
            )),
        Expanded(
            flex: 1,
            child:
            Container(child:
              ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black45),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => add(ultimo: discentes.length)
                    ));
                  });
                },
                child: Icon(Icons.add),
              ),
              margin: new EdgeInsets.all(2.0),
          )
        )
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black12,
                  child: Center(
                      child: Text(discentes[index].nome,
                          style:
                          new TextStyle(color: Colors.black38, fontSize: 30))),
                  width: 150,
                  height: 150,
                  margin: new EdgeInsets.all(2.0),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black12,
                  child: Center(
                      child: Text(discentes[index].matricula,
                          style:
                          new TextStyle(color: Colors.black38, fontSize: 12))),
                  width: 150,
                  height: 150,
                  margin: new EdgeInsets.all(2.0),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black12,
                  child: Center(
                      child: Text(
                          discentes[index].datNasc,
                          style:
                          new TextStyle(color: Colors.black38, fontSize: 12))),
                  width: 150,
                  height: 150,
                  margin: new EdgeInsets.all(2.0),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black12),
                    onPressed: () {
                      setState(() {
                        model().deletarAluno(discentes[index].id);
                        discentes.removeAt(index);
                      });
                    },
                    child: Text(
                      "-",
                      style: new TextStyle(fontSize: 24),
                    ),
                  ),
                  width: 150,
                  height: 150,
                  margin: new EdgeInsets.all(2.0),

                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black12),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                edit(
                                  al: discentes[index],
                                )
                        ));
                      });
                    },
                    child: Text(
                      "editar",
                      style: new TextStyle(fontSize: 12),
                    ),
                  ),
                  width: 150,
                  height: 150,
                  margin: new EdgeInsets.all(2.0),
                )
            ),
          ],
        ));
  }
}
