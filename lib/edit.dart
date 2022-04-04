import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'alunos.dart';
import 'model.dart';
import 'package:intl/intl.dart';


class edit extends StatefulWidget {
  edit({Key? key, required this.al}) : super(key: key);
  final alunos al;
  @override
  State<edit> createState() => _editState(al);
}

class _editState extends State<edit> {
  _editState(this.al);
  TextEditingController dateinput = TextEditingController();
  final alunos al;
  final txtNome = TextEditingController();
  final txtMatricula = TextEditingController();
  @override
  Widget build(BuildContext context) {
    txtNome.text = al.nome;
    txtMatricula.text = al.matricula;
    dateinput.text = al.datNasc;
    return Scaffold(
      appBar: AppBar(title: Text("Editar - " + al.nome)),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: txtNome,
              decoration: InputDecoration(
                  icon: Icon(Icons.wc), //icon of text field
                  labelText: "Nome" //label text of field
              )
          ),
          alignment: Alignment.centerRight,
          color: Colors.white70,
        ),
        Container(
            padding: EdgeInsets.all(15),
            height:150,
            child:Center(
                child:TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Data de Nascimento" //label text of field
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      dateinput.text = formattedDate; //set output date to TextField value.
                    }else{
                      print("Date is not selected");
                    }
                  },
                )
            )
        )
        ,Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: txtMatricula,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_balance_wallet_outlined), //icon of text field
                  labelText: "Matrícula" //label text of field
              )
          ),
          alignment: Alignment.centerRight,
          color: Colors.white70,
        ),
        Center(
          child:
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black12),
            onPressed: (){
              setState(() {
                alunos a = al;
                a.nome = txtNome.text;
                a.datNasc = dateinput.text;
                a.matricula = txtMatricula.text;
                model().atualizarAluno(a);
                main();
              });
            },
            child: Icon(Icons.arrow_circle_up),
          ),
        )
      ]),
    );
  }
}
