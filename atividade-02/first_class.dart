import 'dart:convert';

// Define a classe Dependente
class Dependente {
  late String _nome;

  Dependente(String nome) {
    _nome = nome;
  }

  // Método para converter o objeto em um mapa para serialização JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

// Define a classe Funcionario
class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    _nome = nome;
    _dependentes = dependentes;
  }

  // Método para converter o objeto em um mapa para serialização JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

// Define a classe EquipeProjeto
class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Método para converter o objeto em um mapa para serialização JSON
  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar vários objetos Dependentes
  Dependente dep1 = Dependente("Maria Silva");
  Dependente dep2 = Dependente("João Silva");
  Dependente dep3 = Dependente("Pedro Souza");

  // 2. Criar vários objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionários
  Funcionario func1 = Funcionario("Carlos Silva", [dep1, dep2]);
  Funcionario func2 = Funcionario("Ana Souza", [dep3]);
  Funcionario func3 = Funcionario("José Santos", []);

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [func1, func2, func3];

  // 5. Criar um objeto EquipeProjeto chamando o método construtor
  EquipeProjeto equipe = EquipeProjeto("Projeto Phoenix", listaFuncionarios);

  // 6. Printar no formato JSON o objeto EquipeProjeto.
  // Usamos jsonEncode para converter o mapa em uma string JSON formatada.
  // O `JsonEncoder.withIndent('  ')` é usado para uma impressão mais legível.
  String jsonEquipe = JsonEncoder.withIndent('  ').convert(equipe.toJson());
  print(jsonEquipe);
}
